module ReportsHelper
  def to_count_csv(reports, counter_column_name)
    rows = []
    rows << "Time,Count"
    rows += reports.map {|report| "#{report.created_at},#{report.send(counter_column_name)}" }
    rows.join("\n")
  end

  def to_commit_week_count_csv(warnings)
    hash = {}
    hash.default = 0
    warnings.each {|warning| hash[warning.modified_at.to_date.beginning_of_week] += 1 }
    rows = []
    rows << "Time,Count"
    rows += hash.map {|date, count| "#{date},#{count}" }
    rows.join("\n")
  end

  def rank_by_author_count(warnings)
    ranks = {}
    ranks.default = 0
    warnings.each {|warning| ranks[warning.author] += 1 }
    ranks.sort_by {|author, count| -count }
  end
end
