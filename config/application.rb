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
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    # was recommended for devise:
    config.assets.initialize_on_precompile = false
  end
end

# from http://stackoverflow.com/questions/7341545/rails-actionviewbase-field-error-proc-moving-up-the-dom-tree
# fix display of errors in form to go well with bootstrap
ActionView::Base.field_error_proc = Proc.new do |html_tag, object|
  html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
  html = html.at_css("input") || html.at_css("textarea")
  unless html.nil?
    css_class = html['class'] || "" 
    html['class'] = css_class.split.push("error").join(' ')
    html_tag = html.to_s + "<span class='help-inline'>" + object.error_message.join(". ") + "</span>"
  end
  html_tag.html_safe
end
