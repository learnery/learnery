require "test_helper"

describe "Topic Suggestion Integration Test" do
  before do
    @event = create(:event)
  end
  context "as an visitor" do
    it "I cannot suggest topics" do
      skip("todo bk - work in progress")
      visit event_path( @event )
      page.wont_have_link(t 'topic.new.suggest')
    end
  end  # /context visitor

  context "as an logged in user" do
    before do
      @user = create(:user)
      login_user( @user )
    end


  end # /context user

end
