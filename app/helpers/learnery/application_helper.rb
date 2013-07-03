module Learnery
module ApplicationHelper
  include Learnery::FormHelper
  #include Learnery::AuthenticationHelper
  include BootstrapFlashHelper
  include Learnery::RsvpHelper



  # for events

  protected
  def admin_only
    #raise "admin only"
    redirect_to root_path, :notice => t(:admin_only)  unless current_user and current_user.admin?
  end
end

end
