require "test_helper"

describe "Topic Display Integration Test" do
  context "as an visitor" do
    it "i get a message that there are no topics" do
      @event = create(:event)
      visit learnery.event_path( @event )
      page.must_have_content(t 'topics.none')
    end
    it "show topics" do
      @topic = create(:topic)
      visit learnery.topic_path( @topic )
      page.must_have_content(@topic.name)
    end
    it "lists topics for event" do
      @event = create(:event)
      @event.topics = [ create(:topic), create(:topic) ]
      @event.save!

      visit learnery.event_path(@event)
      page.must_have_content(@event.topics.first.name)
      page.must_have_content(@event.topics.last.name)
    end
  end  # /context visitor

# context "as an logged in user" do
#   before do
#     @user = create(:user)
#     login_user( @user )
#   end
# end # /context user

end
