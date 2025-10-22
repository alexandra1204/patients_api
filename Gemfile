source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.6'

gem "rails", "~> 8.1.0"
gem "pg", ">= 1.1"
gem "puma"
gem "bootsnap", "~> 1.18.6", require: false
gem "dotenv-rails", groups: [:development, :test]
gem "httparty"
gem "rack-cors"

group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
end
