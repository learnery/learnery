require "test_helper"

describe "Event Creation Integration Test" do

  context "as an visitor" do
    it "do not see links to new event on homepage" do
      past_event   = Event.create!( :name => "event in the past",   :starts => Date.today - 10 )
      visit "/"
      page.wont_have_link(t :new)
      page.wont_have_link(t :edit)
      visit "/events?past=true"
      page.wont_have_link(t :edit)
    end

    it "do not see links to edit an event" do
      future_event = Event.create!( :name => "event in the future", :starts => Date.today + 30 )
      visit event_path( future_event )
      page.wont_have_link(t :edit)
      page.wont_have_link(t :delete)
    end

  end  # /context visitor

  context "as an admin" do

    before do
      user = User.create!( :email => 'user@example.com', :password => '12345678', :admin => true)
      login_user( user )
    end

    it "cannot create without name" do
      visit "/events/new"

      page.must_have_content(:new)
      within('#new_event') do
        fill_in t('activerecord.attributes.event.starts'), with: '2013-03-23 13:19'
        click_button create_button_for(Event)
      end

      page.must_have_content t "errors.messages.blank"
    end


    it "cannot create without start time" do
      visit "/events/new"

      page.must_have_content(:new)
      within('#new_event') do
        fill_in t('activerecord.attributes.event.name'),   with: 'Some Event'
        click_button create_button_for(Event)
      end

      page.must_have_content t "errors.messages.blank"
    end


    it "can create event" do
      visit "/events/new"

      page.must_have_content(:new)
      within('#new_event') do
        fill_in t('activerecord.attributes.event.name'),   with: 'Some Event'
        fill_in t('activerecord.attributes.event.starts'), with: '2013-03-23 13:19'
        click_button create_button_for(Event)
      end

      page.must_have_content("Event was successfully created.")
    end

  end # /context admin

end
