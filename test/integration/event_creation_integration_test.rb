require "test_helper"

describe "Event Creation Integration Test" do

  context "as an visitor" do

    it "displays markdown event-descriptions as html" do
      future_event = create( :event, :name => "event in the future", :starts => Date.today + 30, :description => "## important" )
      visit learnery.event_path( future_event )
      page.must_have_css( 'h2' )
      within 'h2' do
        must_have_content "important"
        wont_have_content "Starts"
      end
    end

    it "do not see links to new event on homepage" do
      past_event   = create( :event, :name => "event in the past",   :starts => Date.today - 10 )
      visit learnery.root_path
      page.wont_have_link(t :new)
      page.wont_have_link(t :edit)
      visit learnery.events_path(past: true) # "/events?past=true"
      page.wont_have_link(t :edit)
    end

    it "do not see links to edit an event" do
      future_event = create( :event, :name => "event in the future", :starts => Date.today + 30 )
      visit learnery.event_path( future_event )
      page.wont_have_link(t :edit)
      page.wont_have_link(t :delete)
    end

  end  # /context visitor

  context "as an admin" do

    before do
      user = create(:admin_user)
      login_user( user )
    end

    it "cannot create without name" do
      visit learnery.new_event_path # "/events/new"

      page.must_have_content(:new)
      within('#new_event') do
        fill_in t('activerecord.attributes.learnery/event.starts'), with: '2013-03-23 13:19'
        click_button create_button_for(Learnery::Event)
      end

      page.must_have_content t "errors.messages.blank"
    end


    it "cannot create without start time" do
      visit learnery.new_event_path # "/events/new"

      page.must_have_content(:new)
      within('#new_event') do
        fill_in t('activerecord.attributes.learnery/event.name'),   with: 'Some Event'
        click_button create_button_for(Learnery::Event)
      end

      page.must_have_content t "errors.messages.blank"
    end


    it "can create event with everything" do
      visit learnery.new_event_path # "/events/new"
      page.must_have_content(:new)
      within('#new_event') do
        fill_in t('activerecord.attributes.learnery/event.name'),   with: 'Some Event'
        fill_in t('activerecord.attributes.learnery/event.starts'), with: '2013-03-23 13:19'
        fill_in t('activerecord.attributes.learnery/event.ends'), with: '2013-03-24 13:19'
        fill_in t('activerecord.attributes.learnery/event.venue'), with: 'here'
        fill_in t('activerecord.attributes.learnery/event.description'), with: 'this is areally long test'
        # todo engine: I18n key in model_name is learnery/rsvp for complete hierarchy
        #select t('activerecord.models.learnery/OpenRsvp')
        select( t 'Learnery::OpenEvent', :scope => 'activerecord.models')
        click_button create_button_for(Learnery::Event)
      end

      page.must_have_content(t 'events.successfully_created' )

    end

  end # /context admin

end
