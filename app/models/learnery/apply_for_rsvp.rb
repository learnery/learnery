module Learnery
  class ApplyForRsvp < Learnery::Rsvp

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

    def available_events_for( user )
      if user.admin then
        available_events
      else
        available_events - [ :confirm ]
      end
    end

    state_machine :answer, :initial => :new do
      after_transition [:new, :no] => [:yes, :waiting] do |rsvp, transition|
        rsvp.asked_now!
      end

      after_transition :yes => :no do |rsvp, transition|
        rsvp.release_place
      end


      event :say_yes do
        transition [:new, :no] => :pending
      end
      event :say_no do
        transition [:new, :pending, :confirmed] => :no
      end
      event :confirm do
        transition [:pending] => :confirmed
      end
    end
  end
end

