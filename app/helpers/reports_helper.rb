module ReportsHelper
  def convert_reports_to_csv(reports)
    rows = []
    rows << ["Date,Count"]
    rows << reports.map {|report| "#{report.created_at.to_date},#{report.warnings_count}" }
    rows.join("\n")
  end
end
