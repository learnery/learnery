require 'test_helper'
module Learnery
class RsvpWithWaitlistTest < ActiveSupport::TestCase

  context "can rsvp" do
    before do
      @event  = Learnery::EventWithWaitlist.create!( :name => 'intresting event', :starts => Date.today + 10, :max_attendees => 2 )
      @user1  = create( :user )
      @user2  = create( :user )
      @user3  = create( :user )
    end

    it "but cannot rsvp twice" do
      assert_raise ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid do
        Learnery::RsvpWithWaitlist.create!( :user => @user1, :event => @event )
        Learnery::RsvpWithWaitlist.create!( :user => @user1, :event => @event )
      end
    end


    it "answer defaults to new" do
      r = Learnery::RsvpWithWaitlist.new( :user => @user1, :event => @event )
      r.save!
      r.answer.must_equal "new"
    end

    it "setting answer to yes saves date" do
      r = @event.rsvp_create!( @user1 )
      r.event.max_attendees.must_equal 2
      r.event.rsvp.where(:answer => "yes").count.must_equal 0
      r.places_available?.must_equal true
      r.say_yes!
      r.answer.must_equal "yes"
      r.asked_at.wont_be_nil
      r.asked_at.must_be_close_to r.created_at, 0.05
    end

    it "third attendee is put on waitlist" do
      @event.max_attendees.must_equal 2
      @event.count_yes.must_equal 0
      @event.places_available?.must_equal true

      r1 = RsvpWithWaitlist.new( :user => @user1, :event => @event )
      r1.say_yes!
      r1.answer.must_equal "yes"
      @event.count_yes.must_equal 1
      @event.places_available?.must_equal true

      r2 = RsvpWithWaitlist.new( :user => @user2, :event => @event )
      r2.say_yes!
      r2.answer.must_equal "yes"
      @event.count_yes.must_equal 2
      @event.places_available?.must_equal false

      r3 = RsvpWithWaitlist.new( :user => @user3, :event => @event )

      r3.say_yes!
      r3.answer.must_equal "waiting"
      @event.count_yes.must_equal 2
      @event.places_available?.must_equal false
    end

    it "if one attendee gives back the ticket, first on waitlist moves up" do
      @event.max_attendees.must_equal 2
      @event.count_yes.must_equal 0
      @event.places_available?.must_equal true

      r1 = RsvpWithWaitlist.new( :user => @user1, :event => @event )
      r1.say_yes!
      r1.answer.must_equal "yes"
      @event.count_yes.must_equal 1
      @event.places_available?.must_equal true

      r2 = RsvpWithWaitlist.new( :user => @user2, :event => @event )
      r2.say_yes!
      r2.answer.must_equal "yes"
      @event.count_yes.must_equal 2
      @event.places_available?.must_equal false

      r3 = RsvpWithWaitlist.new( :user => @user3, :event => @event )

      r3.say_yes!
      r3.answer.must_equal "waiting"
      @event.count_yes.must_equal 2
      @event.places_available?.must_equal false

      r1.say_no!
      r3.reload
      r1.answer.must_equal "no"
      r3.answer.must_equal "yes"
      @event.count_yes.must_equal 2
      @event.places_available?.must_equal false
    end

  end
end
end
