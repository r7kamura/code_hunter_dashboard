class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :provider
      t.string :uid
      t.timestamps
    end
    add_index :users, [:provider, :uid], unique: true
  end
end
