module Learnery
  class EventWithApplication < Learnery::Event

    # validates :application_date, :presence => true

    def rsvp_type
      Learnery::ApplyForRsvp
    end

    # for form_for and link_to helpers:
    # pretend i'm of the superclass
    def self.model_name
      Learnery::Event.model_name
    end

  end
end
