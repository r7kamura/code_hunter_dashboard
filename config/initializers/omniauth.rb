Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Settings.github.client_id, Settings.github.client_secret,
    :scope          => "user:email",
    :client_options => {
      :site          => "https://#{Settings.github.host}/api/v3",
      :authorize_url => "https://#{Settings.github.host}/login/oauth/authorize",
      :token_url     => "https://#{Settings.github.host}/login/oauth/access_token",
    }
end
