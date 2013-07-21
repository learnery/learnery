module Learnery
  class OpenEvent < Learnery::Event

    # for form_for and link_to helpers:
    # pretend i'm of the superclass
    def self.model_name
      Learnery::Event.model_name
    end

  end
end
