source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"
gem "rails", "~> 7.0.6"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"

gem 'jwt'
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 5.0'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'ffaker', '~> 2.23'
  gem "shoulda-matchers"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

