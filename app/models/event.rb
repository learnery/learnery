class Event < ActiveRecord::Base

  # Every event has a name and start time
  # you can find the future and past events by start time with Event.future and Event.past

  validates :name, :starts, :rsvp_type, :max_attendees, :presence => true

  validates :rsvp_type, :inclusion => { :in => ["OpenRsvp", "RsvpWithWaitlist"], :message => "%{value} is not a valid rsvp type"  }

  default_scope { order(:starts) }

  scope :future, -> { where( "starts >= ?", Time.zone.now ) }
  scope :past, -> { where( "starts < ?", Time.zone.now ) }

  # Users can rsvp for events
  # this is actually always 
  has_many :rsvp, :before_add => :check_rsvp_type
  has_many :users, :through => :rsvp

  # bk-tbd
  # event knows about answers enumeration; it is duplicated here.
  # I think all of this functionality belongs in rsvp.

  # 
  def check_rsvp_type(rsvp)
    raise "Incompatible RSVP, should be #{rsvp_type}" unless rsvp.class.to_s == rsvp_type
  end

  # can count rsvps or access them
  def count_rsvps
    rsvp.count
  end

  def users_who_rsvped
    rsvp.map(&:user)
  end

  # can count users with rsvp answer
  def count_rsvps_with_answer(answer)
    rsvp.where(:answer => answer).count
  end
  def users_who_rsvped_with(answer)
    rsvp.where(:answer => answer)
  end

  # can count users who rsvped yes,  or access them
  def count_yes
    rsvp.yes.count
  end
  def users_who_rsvped_yes
    rsvp.yes.map(&:user)
  end

  # can count users who rsvped no,  or access them
  def count_no
    rsvp.no.count
  end
  def users_who_rsvped_no
    rsvp.no.map(&:user)
  end

  # can count users who rsvped maybe,  or access them
  def count_maybe
    rsvp.maybe.count
  end
  def users_who_rsvped_maybe
    rsvp.maybe.map(&:user)
  end

  # get rsvp of this user
  def rsvp_of(user)
    rsvp.where(:user => user).first || rsvp_create(user)
  end

  def places_available?
    return true if max_attendees == 0
    rsvp.where(:answer => :yes).count < max_attendees
  end

  def has_waitlist?
    return false if max_attendees == 0
    rsvp.where(:answer => :waiting).count > 0
  end

  def no_on_waitlist
    rsvp.where(:answer => :waiting).count
  end
  def rsvp_create( user )
    rsvp_type.constantize.create!( :event => self, :user => user )
  end
end
