require "test_helper"

describe "Login Integration Test" do
 
  it "sign up" do
    email_address = 'user@example.com'

    visit root_path
    page.must_have_link t(:sign_up) 
    click_link t(:sign_up) 
    page.must_have_content('Password confirmation')

    within('#new_user') do
      fill_in t('activerecord.attributes.user.email'), :with => email_address
      fill_in t('activerecord.attributes.user.password'), :with => '12345678'
      fill_in t('activerecord.attributes.user.password_confirmation'), :with => '12345678'
      click_button t(:sign_up)
    end
    page.must_have_content t(:signed_in)
    page.must_have_content t(:user_sigend_in, :name => email_address)
  end
 
  it "log in" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )
    page.must_have_content('Signed in successfully')
    page.must_have_content t(:logged_in_as, :name => user.email)
  end

  it "log out" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )

    visit root_path

    page.must_have_link t :logout
    click_link :logout
    page.must_have_content t :signed_out
  end
 
end
