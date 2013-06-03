
require "test_helper"
#integration test has to be in the name otherwise it won't be one.
describe "registration page integration test" do


  def fill_out_registration_form(nickname,email,password, password_confirmation)
    visit new_user_registration_path
    within('#new_user') do
      fill_in t('activerecord.attributes.user.nickname'), :with => nickname if nickname
      fill_in t('activerecord.attributes.user.email'), :with => email if email
      fill_in t('activerecord.attributes.user.password'), :with => password
      fill_in t('activerecord.attributes.user.password_confirmation'), :with => password_confirmation
      click_button t(:sign_up)
    end
  end


  it "signs up new user with email" do
    email_address = 'user@example.com'
    fill_out_registration_form(nil, email_address,'12345678','12345678')
    page.must_have_content t('devise.registrations.signed_up')
    page.must_have_content t(:logged_in_as, :user => email_address)
  end
  it "signs up new user with nickname" do
    nickname = "drblinken"
    fill_out_registration_form(nickname, nil,'12345678','12345678')
    page.must_have_content t('devise.registrations.signed_up')
    page.must_have_content t(:logged_in_as, :user => nickname)
  end

  describe "the combination of nickname and email has to be unique" do
    it "signs up a user with duplicate email, as long as nickname is different" do
      skip("todo bk - work in progress")
      user = create(:user)
      other_nickname = "DifferentFrom#{user.nickname}"
      fill_out_registration_form(other_nickname, user.email,user.password,user.password)
      page.must_have_content t('devise.registrations.signed_up')
      page.must_have_content t(:logged_in_as, :user => nickname)

    end
  end
end
