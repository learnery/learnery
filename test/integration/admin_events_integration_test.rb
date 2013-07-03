require "test_helper"

describe "Admin Events Integration Test" do
  before do
    @user = create(:user)
    @event1 = create(:past_event)
    @event2 = create(:past_event)
    @event3 = create(:past_event)
    @admin = create(:admin_user)
  end
  it "normal user cannot see admin list of events" do
    login_user( @user )
    wont_have_link learnery.admin_events_path

    visit learnery.admin_events_path
    must_have_content t(:admin_only)
  end

  it "admin can see admin list of events" do
    login_user( @admin )
    click_link t 'navigation.events'
    must_have_content @event1.name
    must_have_content @event2.name
    must_have_content @event3.name
  end
end
