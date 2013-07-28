require "test_helper"


describe "Event Creation Javascript Integration Test", :js => true do
  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    user = create(:admin_user)
    login_user( user )
  end

  it "event creation form adapts with event type" do
    visit learnery.new_event_path # "/events/new"
    page.must_have_content(:new)
    within('#new_event') do
      fill_in t('activerecord.attributes.learnery/event.name'),   with: 'Some Event'
      fill_in t('activerecord.attributes.learnery/event.starts'), with: '2013-03-23 13:19'
      fill_in t('activerecord.attributes.learnery/event.venue'), with: 'here'
      fill_in t('activerecord.attributes.learnery/event.description'), with: 'this is areally long test'
      select( t 'Learnery::EventWithWaitlist', :scope => 'activerecord.models')
      page.evaluate_script('$("#event_max_attendees").is(":visible")').must_be :==, true
      page.evaluate_script('$("#event_application_date").is(":visible")').must_be :==, false
      fill_in t('activerecord.attributes.learnery/event.max_attendees'), with: 1
      click_button create_button_for(Learnery::Event)
    end

    page.must_have_content(t 'events.successfully_created' )

  end

end
