class AddTypeToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :type, :string, :default => 'OpenRsvp'
    add_column :rsvps, :asked_at, :datetime
    add_column :rsvps, :confirmed_at, :datetime
  end
end
