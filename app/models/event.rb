class Event < ActiveRecord::Base

  default_scope { order(:starts) }

  scope :future, -> { where( "starts >= ?", Time.zone.now ) }
  scope :past, -> { where( "starts < ?", Time.zone.now ) }

  validates :name, :starts, :presence => true
end
