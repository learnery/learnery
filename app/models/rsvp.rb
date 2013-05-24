class Rsvp < ActiveRecord::Base

  ANSWERS =  %w(yes no maybe)

  # models the many-to-many relation between users and events
  # the DATABASE ensures that there is only one rsvp per ( user x event )
  belongs_to :user
  belongs_to :event

  # and carries some attributes: answer can be yes, no, maybe
  validates :answer, inclusion: { in: ANSWERS, message: "%{value} is not a valid rsvp answer (yes, no, maybe)" }

  scope :yes,    -> { where( :answer => 'yes'   ) }
  scope :no,     -> { where( :answer => 'no'    ) }
  scope :maybe,  -> { where( :answer => 'maybe' ) }

  def answer= value
    self[:answer] = value.to_s
  end

end
