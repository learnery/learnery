require "test_helper"
module Learnery
describe "user login and logout integration test" do

  it "saves a user" do
    assert Learnery::User.count == 0
    user = create(:user_only_with_email)
    assert Learnery::User.count == 1
    u = Learnery::User.first
    assert u.email == "someone2@somehost.xxx"

  end
  it "logs in user with email" do
    user = create(:user_only_with_email)
    login_user( user )
    page.must_have_content t('devise.sessions.signed_in')
    page.must_have_content t(:logged_in_as, :user => user.email)
  end

  it "logs in user with email" do
    user = create(:user_only_with_nickname)
    login_user( user )
    page.must_have_content t('devise.sessions.signed_in')
    page.must_have_content t(:logged_in_as, :user => user.nickname)
  end
  it "logs in the default user" do
    user = create(:user)
    login_user( user )
    page.must_have_content t('devise.sessions.signed_in')
    page.must_have_content t(:logged_in_as, :user => user.nickname)
  end


  it "log out" do
    user = create(:user)
    login_user( user )
    visit learnery.root_path
    click_link t :log_out
    page.must_have_content t 'devise.sessions.signed_out'
  end

end
end
