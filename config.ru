# This file is used by Rack-based servers to start the application.

require ::File.expand_path("../config/environment",  __FILE__)

ActionController::Base.config.relative_url_root = ENV["RAILS_RELATIVE_URL_ROOT"]
map ActionController::Base.config.relative_url_root || "/" do
  run CodeHunterDashboard::Application
end
