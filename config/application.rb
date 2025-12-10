require_relative "boot"

require "rails/all"


Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
   
    config.load_defaults 7.0
    config.api_only = false

    # Локалізація
    config.i18n.default_locale = :uk
    config.i18n.available_locales = [:uk, :en]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Необхідні middleware для роботи ActiveAdmin у проєкті з API-ендпоінтами
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride
  
  end
end

