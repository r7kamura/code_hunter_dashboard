source "https://rubygems.org"

gem "rails", "3.2.11"
gem "mysql2"
gem "jquery-rails"
gem "slim"
gem "thin"
gem "font-awesome-sass-rails"
gem "omniauth-github", :git => "git://github.com/intridea/omniauth-github.git"
gem "settingslogic"
gem "dotenv"

group :development do
  gem "pry-rails"
  gem "quiet_assets"
  gem "tapp"
end

group :test do
  gem "rspec", ">=2.12.0"
  gem "rspec-rails", ">=2.12.0"
  gem "factory_girl_rails", "~> 4.0"
  gem "response_code_matchers"
end

group :production do
  gem "unicorn"
end

group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :capistrano do
  gem "capistrano"
  gem "capistrano_colors"
end
