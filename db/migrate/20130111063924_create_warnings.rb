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
      t.references :report

      t.timestamps
    end

    add_index :warnings, [:report_id, :modified_at]
  end
end
