require "test_helper"

describe "Login Integration Test" do
 
  it "sign up" do
    email_address = 'user@example.com'

    visit root_path
    page.must_have_link t(:sign_up) 
    click_link t(:sign_up) 
    page.must_have_content(t 'activerecord.attributes.user.password_confirmation')

    within('#new_user') do
      fill_in t('activerecord.attributes.user.email'), :with => email_address
      fill_in t('activerecord.attributes.user.password'), :with => '12345678'
      fill_in t('activerecord.attributes.user.password_confirmation'), :with => '12345678'
      click_button t(:sign_up)
    end
    page.must_have_content t('devise.registrations.signed_up')
    page.must_have_content t(:logged_in_as, :user => email_address)
  end
 
  it "log in" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )
    page.must_have_content t('devise.sessions.signed_in')
    page.must_have_content t(:logged_in_as, :user => user.email)
  end

  it "log out" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )

    visit root_path

    page.must_have_link t :log_out
    click_link t :log_out
    page.must_have_content t 'devise.sessions.signed_out'
  end
 
end
