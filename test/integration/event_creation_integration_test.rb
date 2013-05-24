require "test_helper"

describe "Event Creation Integration Test" do
 
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
 
end
