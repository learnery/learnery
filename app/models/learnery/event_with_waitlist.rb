module Learnery
  class EventWithWaitlist < Learnery::Event

    validates :max_attendees, :presence => true

    def rsvp_type
      Learnery::RsvpWithWaitlist
    end

    # for form_for and link_to helpers:
    # pretend i'm of the superclass
    def self.model_name
      Learnery::Event.model_name
    end

    def release_place
      if has_waitlist?
        promote_from_waitlist
      end
    end

    def promote_from_waitlist
      first_on_waitlist = rsvp.where(:answer => :waiting).order(:asked_at => :desc).first
      first_on_waitlist.say_no   # transistioning from waiting to yes will not work!
      first_on_waitlist.say_yes
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

  end
end
