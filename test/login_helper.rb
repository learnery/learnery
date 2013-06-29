# TODO: move me somewhere
module LoginHelper
  delegate :t, :to => I18n

  def login_user(user)
    if user.email.blank?
      login_user_with(user.nickname,user.password)
    else
      login_user_with(user.email,user.password)
    end
  end

  def login_user_with(login,password)
    visit learnery.new_user_session_path
    within "#new_user" do
      fill_in t('activerecord.attributes.learnery/user.login'), :with => login
      fill_in t('activerecord.attributes.learnery/user.password'), :with => password
      click_button t('login')
    end
  end

end
