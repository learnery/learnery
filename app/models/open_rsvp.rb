class OpenRsvp < Rsvp 

  state_machine :answer, :initial => :yes do
    event :say_yes do
      transition [:maybe, :no] => :yes
    end
    event :say_no do
      transition [:maybe, :yes] => :no
    end
    event :say_maybe do
      transition [:yes, :no] => :maybe
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
