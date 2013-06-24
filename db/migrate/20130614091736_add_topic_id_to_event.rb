class AddTopicIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :topic_id, :integer
  end
end
