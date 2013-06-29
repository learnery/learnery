#module Learnery
# app/controllers/registrations_controller.rb
# http://stackoverflow.com/questions/3546289/override-devise-registrations-controller
  class RegistrationsController < Devise::RegistrationsController
    before_filter :user_only,  :only => [ :edit]

    def edit
      raise "hit"
      super
    end

    def new
      super
    end

    def create
      super
    end

    def update
      super
    end
    def sign_up_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end
  end
#end

