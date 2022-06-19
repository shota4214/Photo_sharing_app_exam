require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module PicChum
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = %i(ja en)
    config.i18n.enforce_available_locales = true
    config.load_defaults 6.0
    config.generators do |g|
      g.assets false
      g.helper false
    end
  end
end
