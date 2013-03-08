class ReportMailer < ActionMailer::Base
  default from: Settings.mailer.from

  def self.deliver_summary_mails
    groups = Report.latest.warnings.recently_modified.modified_in_this_week.limit(20).group_by(&:email)
    groups.sort_by {|email, warnings| email }.each do |email, warnings|
      summary_mail(email, warnings).deliver
    end
  end

  def summary_mail(email, warnings)
    @warnings = warnings
    mail(:subject => "CodeHunter Report on #{Date.today}", :to => email)
  end
end
