module Learnery
  class Topic < ActiveRecord::Base
    validates :name, :suggested_by, presence: true

    belongs_to :suggested_by, class_name: "User"
    belongs_to :presented_by, class_name: "User"
    belongs_to :event

    def event_name
      return nil if event.nil?
      event.name
    end
    def presented_by_name
      return nil if presented_by.nil?
      presented_by.name
    end
  end
end
