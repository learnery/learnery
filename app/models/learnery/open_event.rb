module Learnery
  class OpenEvent < Learnery::Event

    def rsvp_type
      Learnery::OpenRsvp
    end

    # for form_for and link_to helpers:
    # pretend i'm of the superclass
    def self.model_name
      Learnery::Event.model_name
    end

  end
end
