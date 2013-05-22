class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname,  :string
    add_column :users, :firstname, :string
    add_column :users, :lastname,  :string
    add_index :users, :nickname
    add_index :users, :firstname
    add_index :users, :lastname
  end
end
