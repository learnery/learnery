# This migration comes from learnery (originally 20131006204942)
class AddTopicsEnabledToLearneryEvents < ActiveRecord::Migration
  def change
    add_column :learnery_events, :topics_enabled, :boolean, default: true, null: false
  end
end
