class AddRsvpTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :rsvp_type, :string, :null => false, :default => "OpenRsvp"
  end
end
