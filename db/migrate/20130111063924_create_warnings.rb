class CreateWarnings < ActiveRecord::Migration
  def change
    create_table :warnings do |t|
      t.string :service
      t.string :path
      t.string :message
      t.string :sha1
      t.string :author
      t.string :email
      t.datetime :modified_at
      t.integer :line

      t.timestamps
    end

    add_index :warnings, [:modified_at, :created_at, :service]
    add_index :warnings, [:modified_at, :author]
  end
end
