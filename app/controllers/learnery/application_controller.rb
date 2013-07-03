
# defined here as
# ../application_controller.rb
# is not loaded if overwritten in main_app
class ApplicationController < ActionController::Base
  include Learnery::ViewPathHelper

  before_filter :prepend_dummy_path
end


module Learnery
  class ApplicationController < ActionController::Base

    include Learnery::ApplicationHelper
    include Learnery::AuthenticationHelper
    include Learnery::RsvpHelper
    include Learnery::ViewPathHelper
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :prepend_dummy_path
  end
end
