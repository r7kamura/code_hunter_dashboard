class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :warnings_count

      t.timestamps
    end

    add_index :reports, :created_at
  end
end
