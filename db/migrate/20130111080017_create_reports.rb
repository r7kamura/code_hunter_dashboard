class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :brakeman_count, :default => 0
      t.integer :rails_best_practices_count, :default => 0

      t.timestamps
    end

    add_index :reports, :created_at
  end
end
