class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|

      t.timestamps
    end

    add_index :reports, :created_at
  end
end
