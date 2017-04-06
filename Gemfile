source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'active_model_serializers'
gem 'devise_token_auth'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'rack-cors', require: 'rack/cors'
gem 'cancancan'
gem 'carrierwave'
gem 'mini_magick'
gem 'cloudinary'
gem 'rolify'

group :development, :test do
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing', git: 'https://github.com/rails/rails-controller-testing'
  gem 'ffaker'
  gem 'rubocop'
  gem 'simplecov'
  gem 'awesome_print'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
