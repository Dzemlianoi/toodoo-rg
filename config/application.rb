require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Toodoo
  class Application < Rails::Application
    config.api_only = true
    config.assets.initialize_on_precompile = false
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
                 headers: :any,
                 expose:  %w[access-token expiry token-type uid client],
                 methods: %i[get post options patch delete put]
      end
    end
  end
end
