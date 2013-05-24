class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :answer, :default => :yes
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :rsvps, [:user_id, :event_id], :unique => true
  end

end
