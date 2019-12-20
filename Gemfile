# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "bootsnap", ">= 1.4.2", require: false
gem "dotenv-rails"
gem "html2slim"
gem "jbuilder", "~> 2.7"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rails", "~> 6.0.0"
gem "sass-rails", "~> 5"
gem "slim-rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"
gem "sorcery"
gem "font-awesome-sass", "~> 5.11.2"
gem "chartkick"
gem "meta-tags"
gem "ransack"
gem "kaminari"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "rubocop-performance"
  gem "slim_lint"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "letter_opener"
  gem "bullet"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
