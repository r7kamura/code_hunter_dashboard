class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env

  def self.github_api_endpoint
    "https://#{github.host}/api/v3"
  end
end
