module ReportsHelper
  def to_count_csv(reports, counter_column_name)
    rows = []
    rows << "Time,Count"
    rows += reports.map {|report| "#{report.created_at},#{report.send(counter_column_name)}" }
    rows.join("\n")
  end
end
