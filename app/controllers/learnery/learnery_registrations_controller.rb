module Learnery
# app/controllers/registrations_controller.rb
# http://stackoverflow.com/questions/3546289/override-devise-registrations-controller
# it had to be named different from RegistrationsController to actually work.
  class LearneryRegistrationsController < Devise::RegistrationsController
    include Learnery::AuthenticationHelper
    before_filter :user_only,  :only => [ :edit, :index]
    before_filter :admin_only,  :only => [ :update, :destroy]
    before_filter :configure_permitted_parameters

    def edit
      super
    end

    def new
      super
    end

    def create
      super
    end

    def update
      debugger
      super
    end
    def sign_up_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end
    def user_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :admin)
    end
protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nickname, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      debugger
      if  User.can_become_admin? or ( current_user and current_user.admin? )
        u.permit(:email, :nickname, :firstname, :lastname, :password, :password_confirmation, :current_password, :admin )
      else
        u.permit(:email, :nickname, :firstname, :lastname, :password, :password_confirmation, :current_password )
      end
    end
  end
  end
end

