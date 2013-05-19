require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Learnery
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.assets.paths << File.join( Rails.root, 'app', 'assets', 'fonts') 

    # try to load the theme
    theme_folder      =     File.join( Rails.root, 'theme') 
    theme_initializer =     File.join( Rails.root, 'theme', 'initializer.rb'  ) 

    if ! File.directory?( theme_folder) or ! File.exists?( theme_initializer )  then
      puts "Your installation of learnery needs a theme-folder!"
      puts "run rails generate theme to get a blank theme,"
      puts "or get a readymade theme at https://github.com/learnery/"
    else
      puts "Loading Theme from #{theme_initializer}"
      require( theme_initializer )
      puts "This theme says the site is #{SITE_NAME}"

      # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
      # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
      config.i18n.default_locale = SITE_LOCALE

      config.paths['app/views'].unshift( File.join( Rails.root, 'theme', 'views'       ) )
      config.assets.paths.unshift(       File.join( Rails.root, 'theme', 'fonts'       ) )
      config.assets.paths.unshift(       File.join( Rails.root, 'theme', 'images'      ) )
      config.assets.paths.unshift(       File.join( Rails.root, 'theme', 'stylesheets' ) )
      config.assets.paths.unshift(       File.join( Rails.root, 'theme', 'javascript'  ) )
    end



  end
end
