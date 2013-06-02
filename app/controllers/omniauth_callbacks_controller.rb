class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    #raise request.env["omniauth.auth"].inspect
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in with #{user.provider}!"
      if !user.email || "" == user.email
        flash.notice += "\nPlease provide an email adress if you want to receive notifications."
      end
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  Learnery::Application.config.oauth_providers.each do | oauth_provider |
    alias_method oauth_provider, :all
  end
end
