
require "test_helper"

#integration test has to be in the name otherwise it won't be one.
describe "registration page integration test" do
  it "signs up new user with email" do
    email_address = 'user@example.com'
     visit new_user_registration_path

    within('#new_user') do
      fill_in t('activerecord.attributes.user.email'), :with => email_address
      fill_in t('activerecord.attributes.user.password'), :with => '12345678'
      fill_in t('activerecord.attributes.user.password_confirmation'), :with => '12345678'
      click_button t(:sign_up)
    end
    page.must_have_content t('devise.registrations.signed_up')
    page.must_have_content t(:logged_in_as, :user => email_address)
  end
end
