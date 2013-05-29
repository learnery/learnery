require "test_helper"

describe "Event Creation Integration Test" do

  context "as an visitor" do
    it "do not see links to new event on homepage" do
      past_event   = Event.create!( :name => "event in the past",   :starts => Date.today - 10 )
      visit "/"
      page.wont_have_link("New")
      page.wont_have_link("Edit")
      visit "/events?past=true"
      page.wont_have_link("Edit")
    end

    it "do not see links to edit an event" do
      future_event = Event.create!( :name => "event in the future", :starts => Date.today + 30 )
      visit event_path( future_event )
      page.wont_have_link("Edit")
      page.wont_have_link("Delete")
    end

  end  # /context visitor

  context "as an admin" do

    before do
      user = User.create!( :email => 'user@example.com', :password => '12345678', :admin => true)
      login_user( user )
    end

    it "cannot create without name" do
      visit "/events/new"

      page.must_have_content('New')
      within('#new_event') do
        fill_in 'Starts', with: '2013-03-23 13:19'
        click_button 'Create Event'
      end

      page.must_have_content("can't be blank")
    end


    it "cannot create without start time" do
      visit "/events/new"

      page.must_have_content('New')
      within('#new_event') do
        fill_in 'Name',   with: 'Some Event'
        click_button 'Create Event'
      end

      page.must_have_content("can't be blank")
    end


    it "can create event" do
      visit "/events/new"

      page.must_have_content('New')
      within('#new_event') do
        fill_in 'Name',   with: 'Some Event'
        fill_in 'Starts', with: '2013-03-23 13:19'
        click_button 'Create Event'
      end

      page.must_have_content("Event was successfully created.")
    end

  end # /context admin

end
