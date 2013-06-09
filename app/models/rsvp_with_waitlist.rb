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

  state_machine :answer, :initial => :maybe do

    after_transition :maybe => any do |rsvp, transition|
      rsvp.asked_now!
    end

    event :say_yes do
      transition [:no, :maybe] => :yes,     :if     => :places_available?
      transition [:no, :maybe] => :waiting
    end
    event :say_no do
      transition [:yes, :no, :waiting] => :no
    end
    event :say_maybe do
      transition [:yes, :no, :waiting] => :maybe
    end
  end
end

