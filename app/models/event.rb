class Event < ActiveRecord::Base

  scope :future, -> { where( "starts >= ?", Time.zone.now ) }
  scope :past, -> { where( "starts < ?", Time.zone.now ) }

end
