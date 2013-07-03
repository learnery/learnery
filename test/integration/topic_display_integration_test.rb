require "test_helper"

describe "Topic Display Integration Test" do
  context "as an visitor" do
    it "i get a message that there are no topics" do
      @event = create(:event)
      visit learnery.event_path( @event )
      page.must_have_content(t 'topics.none')
    end
    it "lists topics for event" do
      @event_with_two_topics = create(:event_with_two_topics)
      visit learnery.event_path( @event_with_two_topics )
      page.must_have_content(@event_with_two_topics.topics.first.name)
      page.must_have_content(@event_with_two_topics.topics.last.name)
    end
  end  # /context visitor

# context "as an logged in user" do
#   before do
#     @user = create(:user)
#     login_user( @user )
#   end
# end # /context user

end
