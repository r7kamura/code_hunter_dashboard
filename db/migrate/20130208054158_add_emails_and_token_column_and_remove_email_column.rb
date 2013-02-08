class AddEmailsAndTokenColumnAndRemoveEmailColumn < ActiveRecord::Migration
  def up
    add_column :users, :emails, :string
    add_column :users, :token, :string
    remove_column :users, :email
  end

  def down
    remove_column :users, :emails
    remove_column :users, :token
    add_column :users, :email, :string
  end
end
