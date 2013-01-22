require "bundler"
require "bundler/capistrano"
Bundler.require(:capistrano)

load "deploy/assets"

module CodeHunterDashboard
  class CapistranoEnvValidator
    def self.validate(*args)
      new(*args).validate
    end

    def initialize(required_variables)
      @required_variables = required_variables
    end

    def validate
      unless valid?
        warn error_message
      end
    end

    def valid?
      ENV.values_at(*@required_variables).all?
    end

    def error_message
      "The environment variables #@required_variables are required."
    end
  end
end
CodeHunterDashboard::CapistranoEnvValidator.validate(
  %w[
    CAPISTRANO_DEPLOY_TO
    CAPISTRANO_SERVER
    CAPISTRANO_USER
  ]
)

set :application, "code_hunter_dashboard"
set :use_sudo, false
set :keep_releases, 5
set :deploy_via, :copy
set :bundle_without, [:development, :test, :capistrano]
set :repository, "git@github.com:r7kamura/code_hunter_dashboard.git"
set :user,      ENV["CAPISTRANO_USER"]
set :deploy_to, ENV["CAPISTRANO_DEPLOY_TO"]

server ENV["CAPISTRANO_SERVER"] || "dummy", :web, :app, :db, :primary => true

namespace :deploy do
  desc "Start unicorn server"
  task :start do
    run "/etc/init.d/unicorn start"
  end

  desc "Restart unicorn server"
  task :restart, :roles => :app do
    run "/etc/init.d/unicorn graceful"
  end

  desc "Stop unicorn servers"
  task :stop, :roles => :app do
    run "/etc/init.d/unicorn stop"
  end

  # Overwrite deploy:assets:precompile to cancel precompilation unless assets changed
  namespace :assets do
    desc "Run the asset precompilation rake task if assets changed"
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      modified = capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
      if previous_release.nil? || modified
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end
