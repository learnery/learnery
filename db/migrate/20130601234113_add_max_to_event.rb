class AddMaxToEvent < ActiveRecord::Migration
  def change
    add_column :events, :max_attendees, :integer, :null => false, :default => 0
  end
end
