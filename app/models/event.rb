class Event < ActiveRecord::Base

  # Every event has a name and start time
  # you can find the future and past events by start time with Event.future and Event.past

  validates :name, :starts, :presence => true

  default_scope { order(:starts) }

  scope :future, -> { where( "starts >= ?", Time.zone.now ) }
  scope :past, -> { where( "starts < ?", Time.zone.now ) }

  # Users can rsvp for events

  has_many :rsvp
  has_many :users, :through => :rsvp

  # bk-tbd
  # event knows about answers enumeration; it is duplicated here.
  # I think all of this functionality belongs in rsvp.

  # can count rsvps or access them
  def count_rsvps
    rsvp.count
  end

  def users_who_rsvped
    rsvp.map(&:user)
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
    rsvp.where(:user => user).first || rsvp.build
  end

end
