require "test_helper"

describe "Topic Suggestion Integration Test" do
  before do
    @event = create(:event)
  end
  context "as an visitor" do
    it "I cannot suggest topics" do
      visit event_path( @event )
      page.wont_have_link(t 'topic.new.suggest')
    end
  end  # /context visitor

  context "as an logged in user" do
    before do
      user = create(:user)
      login_user( user )
    end

    it "sees suggest topic link" do
      visit event_path( @event )
      page.must_have_link(t 'topic.new.suggest')
    end
  end # /context admin

end
