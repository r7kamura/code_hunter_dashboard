module ReportsHelper
  def to_csv(reports, counter_column_name)
    rows = []
    rows << ["Time,Count"]
    rows << reports.map {|report| "#{report.created_at},#{report.send(counter_column_name)}" }
    rows.join("\n")
  end

  def rank_by_author_count(warnings)
    ranks = {}
    ranks.default = 0
    warnings.each_with_object(ranks) do |warning, hash|
      hash[warning.author] += 1
    end
    ranks.sort_by {|author, count| -count }
  end
end
