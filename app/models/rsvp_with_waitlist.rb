class RsvpWithWaitlist < Rsvp

  delegate :places_available?, :has_waitlist?, :no_on_waitlist, :to => :event

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

    after_transition [:new, :maybe, :no] => [:yes, :waiting] do |rsvp, transition|
      rsvp.asked_now!
    end

    event :say_yes do
      transition [:new, :no, :maybe] => :yes,     :if     => :places_available?
      transition [:new, :no, :maybe] => :waiting
    end
    event :say_no do
      transition [:new, :yes, :maybe, :waiting] => :no
    end
    event :say_maybe do
      transition [:new, :yes, :no, :waiting] => :maybe
    end
  end
end

