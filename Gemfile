source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'
gem 'aws-sdk-s3', require: false
gem 'bcrypt', '3.1.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'carrierwave', '~> 2.0'
gem "chartkick"
gem 'coffee-rails', '~> 4.2'
gem 'faker'
gem 'kaminari'
gem 'mini_magick'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.4'
gem 'rails-i18n'
gem 'sass-rails', '~> 5.0'
gem 'simple_calendar'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'launchy'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
  gem 'selenium-webdriver'
end

group :development, :production, :test do
  gem 'letter_opener_web'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
