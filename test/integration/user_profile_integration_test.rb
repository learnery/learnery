require "test_helper"

describe "User Profile Integration Test" do

  context "a user" do

    before do
      @user = create(:user)
      @pw = @user.password
    end

    it "cannot edit profile without login" do
      visit "/users/edit"
      page.must_have_content t('devise.failure.unauthenticated')
    end

    it "cannot edit profile without supplying old password" do
      login_user( @user )

      visit "/users/edit"
      page.must_have_content( t 'devise.registrations.edit.title' )
      within('#edit_user') do
        fill_in t('activerecord.attributes.learnery/user.email'), :with => 'some@new.address'
        click_button t('update')
      end

      page.must_have_content t('errors.messages.blank')
    end

    it "can edit name" do
      nick  = 'some nickname'
      first = 'some firstname'
      last  = 'some lastname'
      login_user( @user )

      visit "/users/edit"

      page.must_have_content( t 'devise.registrations.edit.title' )
      within('#edit_user') do
        fill_in t('activerecord.attributes.learnery/user.nickname'),  :with => nick
        fill_in t('activerecord.attributes.learnery/user.firstname'), :with => first
        fill_in t('activerecord.attributes.learnery/user.lastname'),  :with => last
        fill_in t('activerecord.attributes.learnery/user.current_password'),  :with => @pw
        click_button t('update')
      end
      page.must_have_content t('devise.registrations.updated')

    end

  end
end
