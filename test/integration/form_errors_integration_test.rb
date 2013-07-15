require "test_helper"

describe "Form Errors Integration Test" do

  context "as an admin" do

    before do
      user = create(:admin_user)
      login_user( user )

      @event = create(:event)
    end

    it "can edit event" do
      visit learnery.edit_event_path( @event )  # "/events/new"
      page.must_have_content(:edit)
      within("#edit_event_#{@event.id}") do
        fill_in t('activerecord.attributes.learnery/event.starts'), with: ''
        click_button update_button_for(Learnery::Event)
      end

      page.wont_have_content("Event was successfully created.")
      page.must_have_content(t "errors.messages.blank")
      puts page.body
    end

  end # /context admin

end
