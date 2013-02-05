class AddUrlColumnToWarning < ActiveRecord::Migration
  def change
    add_column :warnings, :url, :string
  end
end
