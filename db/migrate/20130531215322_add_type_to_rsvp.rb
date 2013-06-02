class AddTypeToRsvp < ActiveRecord::Migration
  def up
    add_column :rsvps, :type, :string, :default => 'OpenRsvp'
    add_column :rsvps, :asked_at, :datetime
    add_column :rsvps, :confirmed_at, :datetime
    change_column :rsvps, :answer, :string, :default => nil
  end

  def down
    remove_column :rsvps, :type
    remove_column :rsvps, :asked_at
    remove_column :rsvps, :confirmed_at
    change_column :rsvps, :answer, :string, :default => "yes"
  end
end
