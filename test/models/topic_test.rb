require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  context "can create" do
    before do
      @user    = create(:user)
      @event   = create(:event)
    end

    it "cannot be created without name" do
      topic   = Learnery::Topic.create( :name => "", :event => @event, :suggested_by => @user )
      topic.valid?.must_equal false
    end

    it "cannot be created without suggested_by" do
      topic   = Learnery::Topic.create( :name => "some topic", :event => @event )
      topic.valid?.must_equal false
    end

    it "cannot be created with an event that has topics disabled" do
      event = create(:event_with_topics_disabled)
      topic   = Learnery::Topic.create( name: "some topic", event: event, suggested_by: @user )
      topic.valid?.must_equal false
    end

    it "can be created without event" do
      topic   = Learnery::Topic.create( :name => "some topic", :suggested_by => @user )
      topic.valid?.must_equal true
    end
  end
end
