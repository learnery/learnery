ENV["RAILS_ENV"] ||= "test"
# engine todo: uncomment this and delete config/environment?
#require File.expand_path('../../config/environment', __FILE__)
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'login_helper'
require 'learnery'
#require 'factory_girl_rails'
FactoryGirl.definition_file_paths = %w(test/factories)
FactoryGirl.find_definitions

Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # todo engine : this was generated - necessary?
  Rails.backtrace_cleaner.remove_silencers!

  # Add more helper methods to be used by all tests here...
end

# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include LoginHelper
  include FactoryGirl::Syntax::Methods

  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end

  # helpers for i18n
  # use the 't' method in test directly

  delegate :t, :to => I18n

  # create the text on the standard buttons (new, create)
  def create_button_for(klass)
    return "#{klass.model_name.human} #{t(:create).downcase}" if I18n.locale == :de
    return "#{t(:create)} #{klass.model_name.human}"
  end
  def new_button_for(klass)
    return "#{klass.model_name.human} #{t(:new).downcase}" if I18n.locale == :de
    return "#{t(:new)} #{klass.model_name.human}"
  end
  def update_button_for(klass)
    return "#{klass.model_name.human} #{t(:update).downcase}" if I18n.locale == :de
    return "#{t(:update)} #{klass.model_name.human}"
  end

end

class ActionController::TestCase
  include Devise::TestHelpers
  def learnery
    @controller.learnery
  end
end
