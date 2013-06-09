class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.integer :event_id
      t.integer :suggested_by_id
      t.integer :presented_by_id

      t.timestamps
    end
  end
end
