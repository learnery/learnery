require "test_helper"

describe "Admin Integration Test" do
  def user_profile_link(user)
    t(:logged_in_as, :user => user.user_info)
  end

  context "creating admin account" do

    it "first user can become admin" do
      user = User.create!( :email => 'user@example.com', :password => '12345678')
      login_user( user )
      page.must_have_content  user_profile_link(user)
      click_link user_profile_link(user)

      check   t("activerecord.attributes.user.admin")
      fill_in t("activerecord.attributes.user.current_password"), :with => '12345678'

      click_button t(:update)

      page.must_have_content t('devise.registrations.updated')
      user.reload
      assert user.admin, "user is now an admin"
    end

    it "If there's already an admin you can't become admin" do
      admin = User.create!( :email => 'admin@example.com', :password => '12345678', :admin => true )
      user  = User.create!( :email => 'user@example.com',  :password => '12345678')
      login_user( user )

      click_link user_profile_link(user)

      page.wont_have_content "Admin"
    end

    it "admin can make other user an admin" do
      admin = User.create!( :email => 'admin@example.com', :password => '12345678', :admin => true )
      user  = User.create!( :email => 'user@example.com',  :password => '12345678')
      login_user( admin )

      click_link user_profile_link(admin)

      page.must_have_link t("people")
      click_link t("people")

      within "#person_#{user.id}" do
        must_have_content t(:edit)
        click_link t(:edit)
      end

      check t("activerecord.attributes.user.admin")

      click_button t(:update)
      user.reload
      assert user.admin, "user is now an admin"
    end

  end


  context "looking up information on all registered users" do
    before do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @admin = create(:admin_user)
    end
    it "normal user cannot see list of all users" do
      login_user( @user1 )
      wont_have_link t("people")

      visit people_path
      must_have_content t(:admin_only)
    end

    it "admin can see list of all users" do
      login_user( @admin )
      click_link t("people")
      must_have_content @admin.nickname
      must_have_content @user1.nickname
      must_have_content @user2.nickname
      must_have_content @user3.nickname
    end
  end

  context "detailed info on rsvps" do
    before do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @admin = create(:admin_user)
    end

    it "normal user cannot see list of all rsvps" do
      login_user( @user1 )
      visit event_path( @event )
      wont_have_link t(:manage)

      visit admin_event_path( @event )
      must_have_content t(:admin_only)
    end

    context "OpenRsvp" do
      before do
        @event = create(:event)
        @event.rsvp_type = "OpenRsvp"
        @event.save!
      end

      it "admin can see list of all rsvps" do
        @event.rsvp_create( @user1 ).say_yes
        @event.rsvp_create( @user2 ).say_no
        @event.rsvp_create( @user3 ).say_maybe
        login_user( @admin )
        visit event_path( @event )
        click_link t("manage")
        must_have_content @admin.nickname
        must_have_content @user1.nickname
        must_have_content @user2.nickname
        must_have_content @user3.nickname
      end
    end # context OpenRsvp

    context "RsvpWithWaitlist" do
      before do
        @event = create(:event)
        @event.rsvp_type = "RsvpWithWaitlist"
        @event.max_attendees = 1
        @event.save!
      end

      it "admin can see list of all rsvps" do
        @event.rsvp_create( @user1 ).say_yes
        @event.rsvp_create( @user2 ).say_no
        @event.rsvp_create( @user3 ).say_maybe
        login_user( @admin )
        visit event_path( @event )
        click_link t("manage")
        must_have_content @admin.nickname
        must_have_content @user1.nickname
        must_have_content @user2.nickname
        must_have_content @user3.nickname
      end
    end # context RsvpWithWaitlist

  end # context "detailed info on rsvps" 

end # describe "Admin Integration Test" 
