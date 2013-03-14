desc <<-EOS
Collect metrics with code_hunter gem and store them.
This task invokes CodeHunter::Runner to collect metrics of a rails application.
You can specify the path to the rails application by ENV['APPLICATION_PATH'].
EOS

task :collect_metrics => :environment do
  runner   = CodeHunter::Runner.new(["--application-path", ENV["APPLICATION_PATH"]])
  warnings = runner.result
  Report.create_with_warnings(warnings)
end
