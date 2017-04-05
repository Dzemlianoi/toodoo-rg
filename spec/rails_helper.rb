ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

require 'rspec/rails'
require 'omniauth'
require 'carrierwave/test/matchers'

ActiveRecord::Migration.maintain_test_schema!
OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ActionDispatch::TestProcess
  config.include CarrierWave::Test::Matchers
  config.include I18n
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
