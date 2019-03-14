require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# standard libs
require "open-uri"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ama
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = ENV.fetch("TZ", "UTC")
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :en
    config.paths.add "lib", eager_load: true
    config.generators.system_tests = nil
    config.action_view.form_with_generates_remote_forms = false
    config.action_view.prefix_partial_path_with_controller_namespace = false
    config.generators do |g|
      g.orm :active_record
      g.assets false
      g.helper false
      g.template_engine :haml
      g.test_framework :rspec, view_specs: false,
                               controller_specs: false,
                               helper_specs: false,
                               routing_specs: false,
                               request_specs: false,
                               fixture: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    config.active_job.queue_adapter = :inline
    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins "*"
    #     resource "/packs/_/_/node_modules/@fontawesome/fontawesome-free-webfonts/webfonts/*", headers: :any, methods: :get
    #   end
    # end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
