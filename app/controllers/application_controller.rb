class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :prepend_theme_in_view_path

  # TODO: find a better place to manipulate the view path - maybe in config somewhere?
  def prepend_theme_in_view_path
    learnery_theme_paths = view_paths.select{|p| p.to_s =~/learnery-theme/ }
    prepend_view_path( learnery_theme_paths )
  end
end
