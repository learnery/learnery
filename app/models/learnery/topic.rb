module Learnery
  class Topic < ActiveRecord::Base
    validates :name, :suggested_by, presence: true
    validate :validate_event_has_topics_enabled

    belongs_to :suggested_by, class_name: "User"
    belongs_to :presented_by, class_name: "User"
    belongs_to :event

    def validate_event_has_topics_enabled
      if event.present?
        errors.add(:event, I18n.t(:event_has_topics_disabled, :scope => 'errors.messages')) unless event.topics_enabled?
      end
    end

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
