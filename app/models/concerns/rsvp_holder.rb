require 'active_support/concern'

module RsvpHolder
  extend ActiveSupport::Concern

  included do
    validates :rsvp_type, :max_attendees, :presence => true

    validates :rsvp_type, :inclusion => { :in => ["Learnery::OpenRsvp", "Learnery::RsvpWithWaitlist"], :message => "%{value} is not a valid rsvp type"  }

    # Users can rsvp for events
    # this is actually always
    has_many :rsvp, :before_add => :check_rsvp_type, :dependent => :destroy
    has_many :users, :through => :rsvp
  end

  def check_rsvp_type(rsvp)
    raise "Incompatible RSVP, should be #{rsvp_type}" unless rsvp.class.to_s == rsvp_type
  end

  # can count rsvps or access them
  def count_rsvps
    rsvp.count
  end

  # can count types of rspvs
  def count_rsvps_by_type
    h = {}
    # todo strange dependency to Event, remove sql!
    Learnery::Event.connection.select_all("SELECT answer, count(id) FROM learnery_rsvps WHERE event_id=#{id} GROUP BY answer").to_a.map{|h| h.map{|k,v| v} }.each{|x| h[x[0].to_sym] = x[1] }
    h
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
    rsvp.where(:user => user).first
  end

  def places_available?
    return true if max_attendees == 0
    count_yes < max_attendees
  end

  def has_waitlist?
    return false if max_attendees == 0
    rsvp.where(:answer => :waiting).count > 0
  end

  def no_on_waitlist
    rsvp.where(:answer => :waiting).count
  end
  def rsvp_new( user )
    rsvp_type.constantize.new( event: self , user: user )
  end
  def rsvp_create!( user )
    rsvp_type.constantize.create!( :event_id => id, :user_id => user.id )
  end
end
