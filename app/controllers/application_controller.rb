class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :prepend_theme_in_view_path
  before_filter :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      if  User.can_become_admin? or ( current_user and current_user.admin? )
        u.permit(:email, :nickname, :firstname, :lastname, :password, :password_confirmation, :current_password, :admin )
      else
        u.permit(:email, :nickname, :firstname, :lastname, :password, :password_confirmation, :current_password )
      end
    end
  end

  # bk tbd: as this is static, it should be possible to move it to config/application.rb
  # see http://stackoverflow.com/questions/10864108/how-to-prepend-rails-view-paths-in-rails-3-2-actionviewpathset

  # TODO: find a better place to manipulate the view path - maybe in config somewhere?
  def prepend_theme_in_view_path
   learnery_theme_paths = view_paths.select{|p| p.to_s =~/learnery-theme/ }
   prepend_view_path( learnery_theme_paths )
  end

  def admin_only
    # raise "admin only"
    redirect_to root_path, :notice => t(:admin_only)  unless current_user and current_user.admin?
  end

end
