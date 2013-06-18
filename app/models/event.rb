class Event < ActiveRecord::Base
  include RsvpHolder
  # Every event has a name and start time
  # you can find the future and past events by start time with Event.future and Event.past

  validates :name, :starts, :presence => true

  default_scope { order(:starts) }

  scope :future, -> { where( "starts >= ?", Time.zone.now ) }
  scope :past, -> { where( "starts < ?", Time.zone.now ) }

  has_many :topics

  def suggested_topics
    topics
  end
end
