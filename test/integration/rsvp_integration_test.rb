require "test_helper"

describe "Rsvp Integration Test" do
 
  context "with a future event" do

    before do
      @e = Event.create!( :name => 'intresting event', :starts => Date.today + 10 )
      @u = User.create!( :email => 'user@example.com', :password => '12345678')
    end
 
    it "cannot rsvp without login" do
      visit event_path(@e)
      page.wont_have_link('rsvp')
    end

    it "user can rsvp" do
      login_user( @u )
      visit event_path( @e )
      page.must_have_link('rsvp')
      click_link 'rsvp' 
      page.must_have_content('you will attend this event')
    end

  end

end
