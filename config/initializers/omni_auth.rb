OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :github,
    ENV["GITHUB_OAUTH_CLIENT_KEY"],
    ENV["GITHUB_OAUTH_CLIENT_SECRET"],
  )
end
