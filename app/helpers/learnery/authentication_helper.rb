module Learnery
  module AuthenticationHelper
    def admin_only
      #raise "admin only"
      redirect_to "/", :notice => t(:admin_only)  unless current_user and current_user.admin?
    end
    def user_only
      #raise "user only"
      redirect_to "/", :notice => t(:user_only)  unless current_user
    end
    # this overwrites devise authenticate user which has trouble finding the right path.
    # it is preferable anyways to not spread a library interface all over the app.
   # def authenticate_user!
   #   user_only
   # end
    # for current_user
    def current_user_is_admin?
      !current_user.nil? && current_user.admin?
    end
  end
end
