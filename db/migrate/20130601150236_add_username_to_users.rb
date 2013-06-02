class AddUsernameToUsers < ActiveRecord::Migration
  def change
    remove_index(:users, :name => 'index_users_on_email', :column =>  :email)
    add_column :users, :username, :string
    add_index :users, [:email, :username], :unique => true
    add_index :users, :email
    add_index :users, :username
  end
end
