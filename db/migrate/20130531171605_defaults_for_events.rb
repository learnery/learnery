class DefaultsForEvents < ActiveRecord::Migration
  def up
    execute "UPDATE events SET description = ' ' WHERE description IS NULL"
    change_column :events, :description, :string, :default => "", :null => false
  end
  def down
    change_column :events, :description, :string, :default => nil, :null => true
  end
end
