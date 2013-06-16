require "test_helper"

describe "Admin Events Integration Test" do
  before do
    @user = create(:user)
    @event1 = create(:event)
    @event2 = create(:event)
    @event3 = create(:event)
    @admin = create(:admin_user)
  end
  it "normal user cannot see admin list of events" do
    login_user( @user )
    wont_have_link admin_events_path

    visit admin_events_path
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
