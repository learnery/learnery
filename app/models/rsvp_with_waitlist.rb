class RsvpWithWaitlist < Rsvp 

  delegate :places_available?, :has_waitlist?, :no_on_waitlist, :to => :event

  def asked_now!
    self[:asked_at] = Time.now
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

  state_machine :answer, :initial => :maybe do

    after_transition any => :yes, :do => :asked_now!

    event :say_yes do
      transition [:maybe, :no] => :yes,     :if     => :places_available?
      transition [:maybe, :no] => :waiting
    end
    event :say_no do
      transition [:maybe, :yes] => :no
    end
    event :say_maybe do
      transition [:yes, :no] => :maybe
    end
  end
end
