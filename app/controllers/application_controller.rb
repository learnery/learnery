class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :prepend_theme_in_view_path
  before_filter :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit(:email, :nickname, :firstname, :lastname, :password, :password_confirmation, :current_password ) 
    end
  end

  # TODO: find a better place to manipulate the view path - maybe in config somewhere?
  def prepend_theme_in_view_path
   learnery_theme_paths = view_paths.select{|p| p.to_s =~/learnery-theme/ }
   prepend_view_path( learnery_theme_paths )
  end

end
