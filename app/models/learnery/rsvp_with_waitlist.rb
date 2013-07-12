module Learnery
  class RsvpWithWaitlist < Learnery::Rsvp

    delegate :places_available?, :has_waitlist?, :no_on_waitlist, :release_place, :to => :event

    def asked_now!
      self[:asked_at] = Time.now if self[:asked_at].nil?
      self.save!
    end

    def initialize(*)
      super
    end

    # for form_for and link_to helpers:
    # pretend i'm of the superclass
    def self.model_name
      Rsvp.model_name
    end

    state_machine :answer, :initial => :new do
      after_transition [:new, :no] => [:yes, :waiting] do |rsvp, transition|
        rsvp.asked_now!
      end

      after_transition :yes => :no do |rsvp, transition|
        rsvp.release_place
      end


      event :say_yes do
        transition [:new, :no] => :yes,     :if     => :places_available?
        transition [:new, :no] => :waiting
      end
      event :say_no do
        transition [:new, :waiting, :yes] => :no
      end
    end
  end
end

