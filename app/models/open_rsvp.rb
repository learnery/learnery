class OpenRsvp < Rsvp 

  state_machine :answer, :initial => :new do
    event :say_yes do
      transition [:new, :no, :maybe] => :yes
    end
    event :say_no do
      transition [:new, :yes, :maybe] => :no
    end
    event :say_maybe do
      transition [:new, :yes, :no] => :maybe
    end
  end

  def initialize(*)
    super
  end

  # for form_for and link_to helpers:
  # pretend i'm of the superclass
  def self.model_name
    Rsvp.model_name
  end
end
