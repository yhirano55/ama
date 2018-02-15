require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.fixture_path = Rails.root.join("spec", "fixtures")
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include ActionDispatch::TestProcess
  config.include OmniAuthHelper

  config.before do |example|
    if example.metadata[:type] == :system
      if example.metadata[:js]
        driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080]
      else
        driven_by :rack_test
      end
    end
  end
end
