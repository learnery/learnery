class AddTopicsEnabledToLearneryEvents < ActiveRecord::Migration
  def change
    add_column :learnery_events, :topics_enabled, :boolean, default: true, null: false
  end
end
