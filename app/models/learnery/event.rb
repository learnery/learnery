module Learnery
  class Event < ActiveRecord::Base
    include ::RsvpHolder
    # Every event has a name and start time
    # you can find the future and past events by start time with Event.future and Event.past

    validates :name, :starts, :presence => true
    validate :validate_starts_before_it_ends

    def validate_starts_before_it_ends
      if ends && starts
        errors.add(:ends, I18n.t(:starts_must_be_before_ends, :scope => 'errors.messages')) if ends <= starts
      end
    end

    default_scope { order(:starts) }

    scope :future, -> { where( "starts >= ?", Time.zone.now ) }
    scope :past, -> { where( "starts < ?", Time.zone.now ) }

    has_many :topics

    def suggested_topics
      topics
    end
  end
end
