require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Toodoo
  class Application < Rails::Application
    config.api_only = true
  end
end
