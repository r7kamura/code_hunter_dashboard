class AddPendaxesCountToReport < ActiveRecord::Migration
  def change
    add_column :reports, :pendaxes_count, :integer
    Report.all.each do |report|
      report.update_attributes(
        :pendaxes_count => report.warnings.where(:service => "pendaxes").count
      )
    end
  end
end
