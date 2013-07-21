require "test_helper"

describe "Admin Rsvps Integration Test" do
  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @admin = create(:admin_user)
    @event = create(:event)
  end

  it "normal user cannot see list of all rsvps" do
    login_user( @user1 )
    visit learnery.event_path( @event )
    wont_have_link t(:manage)

    visit learnery.admin_event_path( @event )
    must_have_content t(:admin_only)
  end

  context "OpenRsvp" do
    before do
      @event = create(:event)
    end

    it "admin can see list of all rsvps" do
      @event.rsvp_create!( @user1 ).say_yes
      @event.rsvp_create!( @user2 ).say_no
      @event.rsvp_create!( @user3 ).say_maybe
      login_user( @admin )
      visit learnery.event_path( @event )
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
      @event.max_attendees = 1
      @event.save!
    end

    it "admin can see list of all rsvps" do
      @event.rsvp_create!( @user1 ).say_yes
      @event.rsvp_create!( @user2 ).say_no
      login_user( @admin )
      visit learnery.event_path( @event )
      click_link t("manage")
      must_have_content @admin.nickname
      must_have_content @user1.nickname
      must_have_content @user2.nickname
    end
  end # context RsvpWithWaitlist

end # describe "Admin Rsvps Integration Test"
