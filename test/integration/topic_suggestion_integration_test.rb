require "test_helper"

describe "Topic Suggestion Integration Test" do
  before do
    @event = create(:event)
  end
  context "not logged in" do
    it "should not see suggest topic link" do
      visit learnery.event_path( @event )
      page.wont_have_content(t 'topic.new.suggest')
    end
  end

  context "two topics for event" do
    before do
      @user = create(:user)
      login_user( @user )
      visit learnery.event_path( @event )
    end

    it "sees suggest topic link" do
      page.must_have_link(t 'topic.new.suggest')
    end

    it "i get an topic creation page with correct presets" do
      visit learnery.event_path( @event )
      click_link(t 'topic.new.suggest')
      page.must_have_content("#{t('activerecord.attributes.learnery/topic.suggested_by')} #{@user.nickname}")
      page.must_have_content("#{t('topics.for_the_event').ucfirst} #{@event.name}")
    end

    it "i can save an new topic" do
      visit learnery.event_path( @event )
      click_link(t 'topic.new.suggest')
      fill_in t('activerecord.attributes.learnery/topic.name'), with: "A New Topic" 
      click_button create_button_for(Learnery::Topic)
      visit learnery.event_path( @event )
      page.must_have_content "A New Topic"
    end
  end # /context user

end
