Dotenv::Railtie.load if defined?(Dotenv) && (Rails.env.development? || Rails.env.test?)

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end
