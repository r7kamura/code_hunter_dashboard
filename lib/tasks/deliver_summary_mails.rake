desc "Sends mails about the recent changes to each modifier"
task :deliver_summary_mails => :environment do
  ReportMailer.deliver_summary_mails
end
