require "test_helper"

describe "Login Integration Test" do
 
  it "sign up" do
    email_address = 'user@example.com'

    visit root_path
    page.must_have_link('Sign up')
    click_link('Sign up')
    page.must_have_content('Password confirmation')

    within('#new_user') do
      fill_in 'Email', :with => email_address
      fill_in 'Password', :with => '12345678'
      fill_in 'Password confirmation', :with => '12345678'
      click_button 'Sign up'
    end
    page.must_have_content('Welcome! You have signed up successfully.')
    page.must_have_content("Logged in as #{email_address}")
  end
 
  it "log in" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )
    page.must_have_content('Signed in successfully')
    page.must_have_content("Logged in as #{user.email}")
  end

  it "log out" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )

    visit root_path

    page.must_have_link('Logout')
    click_link('Logout')
    page.must_have_content('Signed out successfully.')
  end
 
end
