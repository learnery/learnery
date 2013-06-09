class DeleteUsernameFromUser < ActiveRecord::Migration
  def change
    remove_index(:users, :name => 'index_users_on_username', :column =>  :username)
    remove_index(:users, :name => 'index_users_on_email_and_username', :column =>  ["email", "username"])
    remove_column :users, :username, :string
    add_index :users, [:email, :nickname], :unique => true
  end
end
