require "test_helper"

describe "User Profile Integration Test" do

  context "a user" do
    
    before do
      @pw = '12345678'
      @user = User.create!( :email => 'user@example.com', :password => @pw )
    end

    it "cannot edit profile without login" do
      visit "/users/edit"
      page.must_have_content 'You need to sign in or sign up before continuing'
    end

    it "cannot edit profile without supplying old password" do
      login_user( @user )

      visit "/users/edit"

      page.must_have_content('Edit User')
      within('#edit_user') do
        fill_in t('activerecord.attributes.user.email'), :with => 'some@new.address'
        click_button 'Update'
      end

      page.must_have_content "Current passwordcan't be blank"
    end

    it "can edit name" do
      nick  = 'some nickname'
      first = 'some firstname'
      last  = 'some lastname'
      login_user( @user )

      visit "/users/edit"

      page.must_have_content('Edit User')
      within('#edit_user') do
        fill_in 'Nickname',  :with => nick
        fill_in 'Firstname', :with => first
        fill_in 'Lastname',  :with => last
        fill_in 'Current password',  :with => @pw
        click_button 'Update'
      end
      page.wont_have_content "Current passwordcan't be blank"
      page.must_have_content 'You updated your account successfully.'

    end
   
  end
end
