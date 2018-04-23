source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "rails", "5.2.0"

gem "aws-sdk-s3", require: false
gem "counter_culture"
gem "google-analytics-rails"
gem "gretel"
gem "hamlit-rails"
gem "kaminari"
gem "kaminari-i18n"
gem "meta-tags"
gem "newrelic_rpm"
gem "omniauth-github"
gem "pg", "~> 1.0"
gem "puma", "~> 3.11"
gem "pundit"
gem "rack-cors", require: "rack/cors"
gem "rack-user_agent"
gem "rails-i18n"
gem "redcarpet"
gem "seed-fu"
gem "sentry-raven"
gem "somemoji", require: false
gem "table_help"
gem "webpacker", "~> 3.4"

group :development, :test do
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
end

group :development do
  gem "annotate"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "onkcop", require: false
end

group :test do
  gem "capybara"
  gem "chromedriver-helper"
  gem "launchy"
  gem "rspec_junit_formatter"
  gem "selenium-webdriver"
end
