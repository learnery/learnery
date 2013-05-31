require 'test_helper'

class EventTest < ActiveSupport::TestCase

  context "can create" do

    it "cannot be created without starts" do
      event   = Event.create( :name => "next event" )
      event.valid?.must_equal false
    end

    it "cannot be created without name" do
      event   = Event.create( :starts => Date.today + 10 )
      event.valid?.must_equal false
    end

    it "can be created with everything" do
      event_data = {
          :name => "next event",
          :description => "mighty long text" * 10,
          :starts => Date.today + 10,
          :ends => Date.today + 11,
          :venue => "here"
      }

      event   = Event.create( event_data )
      event.valid?.must_equal true
      event.save!
      event.reload
      event.name.must_equal event_data[:name]
      event.description.must_equal event_data[:description]
      event.starts.must_equal event_data[:starts]
      event.ends.must_equal event_data[:ends]
      event.venue.must_equal event_data[:venue]
    end

  end

  context "can find" do
    before do
      @past_event   = Event.create!( :name => "past event",   :starts => Date.today - 10 )
      @next_event   = Event.create!( :name => "next event",   :starts => Date.today + 10 )
      @future_event = Event.create!( :name => "future event", :starts => Date.today + 30 )
    end
    it "can find all past events" do
      f = Event.past

      f.must_include @past_event
      f.wont_include @next_event
      f.wont_include @future_event
    end
    it "can find all future events" do
      f = Event.future

      f.wont_include     @past_event
      f.first.must_equal @next_event
      f.must_include     @future_event
    end
  end

  context "with rsvps" do
    before do
      @e = Event.create!( :name => "future event", :starts => Date.today + 30 )
      @u1 = User.create!( :email => 'user1@example.com', :password => '12345678')
      @u2 = User.create!( :email => 'user2@example.com', :password => '12345678')
      @u3 = User.create!( :email => 'user3@example.com', :password => '12345678')
      @u4 = User.create!( :email => 'user4@example.com', :password => '12345678')

      @r1 = Rsvp.create!( event: @e, user: @u1, answer: :yes    )
      @r2 = Rsvp.create!( event: @e, user: @u2, answer: :no     )
      @r3 = Rsvp.create!( event: @e, user: @u3, answer: :maybe  )
     
    end

    it "can find rsvp of single user" do
      @e.rsvp_of( @u1 ).must_equal @r1
    end

    context "can find them" do
      it { @e.rsvp.must_equal [ @r1, @r2, @r3 ] }
      it { @e.users_who_rsvped.must_equal       [ @u1,  @u2, @u3 ] }
      it { @e.users_who_rsvped_yes.must_equal   [ @u1 ]            }
      it { @e.users_who_rsvped_no.must_equal    [ @u2 ]            }
      it { @e.users_who_rsvped_maybe.must_equal [ @u3 ]            }
    end

    context "can count them" do
      it { @e.count_rsvps.must_equal 3 }
      it { @e.count_yes.must_equal   1 }
      it { @e.count_no.must_equal    1 }
      it { @e.count_maybe.must_equal 1 }
    end

  end

end
