module Learnery
  class Rsvp < ActiveRecord::Base

    # models the many-to-many relation between users and events
    # the DATABASE ensures that there is only one rsvp per ( user x event )
    belongs_to :user
    belongs_to :event

    # tbd: bk: this is a duplication of the enumeration
    scope :yes,    -> { where( :answer => 'yes'   ) }
    scope :no,     -> { where( :answer => 'no'    ) }
    scope :maybe,  -> { where( :answer => 'maybe' ) }

    def answer= value
      self[:answer] = value.to_s
    end

    # all subtypes should implement a state machine!

    def self.implementations
      [ OpenRsvp, RsvpWithWaitlist ]
    end

    def has_waitlist?
      false
    end

    def available_events
      answer_transitions.map(&:event)
    end
  end
end
