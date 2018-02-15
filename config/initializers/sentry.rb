Raven.configure do |config|
  config.environments = %w[production]
  config.dsn = ENV.fetch("SENTRY_DSN") { Rails.application.credentials.dig(:sentry, :dsn) }
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
