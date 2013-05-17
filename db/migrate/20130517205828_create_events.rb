class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :starts
      t.datetime :ends
      t.string :venue
      t.text :description

      t.timestamps
    end
  end
end
