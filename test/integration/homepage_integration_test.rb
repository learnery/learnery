require "test_helper"
module Learnery
describe "Homepage Integration Test" do

  it "may be empty" do
    visit learnery.root_path
    page.must_have_content(t :nothing_planned)
  end


  it "has a link to the registration page" do
    visit learnery.root_path
    page.must_have_link t(:sign_up)
    click_link t(:sign_up)
    page.must_have_content(t 'activerecord.attributes.learnery/user.password_confirmation')
  end

  context "with events" do
    before do
      future_event = create( :event, :name => "event in the future", :starts => Date.today + 30 )
      next_event   = create( :event, :name => "the very next event", :starts => Date.today + 10 )
      past_event   = create( :event, :name => "event in the past",   :starts => Date.today - 10 )
    end
    it "shows upcoming events" do
      visit learnery.root_path
      page.wont_have_content('event in the past')
      page.must_have_content('the very next event')
      page.must_have_content('event in the future')
    end

    it "shows event in the pasts with param past=true" do
      visit learnery.root_path(past: true)
      page.must_have_content('event in the past')
      page.wont_have_content('the very next event')
      page.wont_have_content('event in the future')
    end
  end
end
end
