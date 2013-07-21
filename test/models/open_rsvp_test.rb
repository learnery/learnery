require 'test_helper'

class OpenRsvpTest < ActiveSupport::TestCase

  context "can rsvp" do
    before do
      @event = Learnery::OpenEvent.create!( :name => 'intresting event', :starts => Date.today + 10 )
      @user  = create(:user)
    end

    it "answer defaults to new when creating with new" do
      r = Learnery::OpenRsvp.new( :user => @user, :event => @event )
      r.save!
      r.answer.must_equal "new"
    end

    it "but cannot rsvp twice" do
      assert_raise ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid do
        Learnery::OpenRsvp.create!( :user => @user, :event => @event )
        Learnery::OpenRsvp.create!( :user => @user, :event => @event )
      end
    end

    it "answer defaults to new when creating from event" do
      r = @event.rsvp_create!( @user )
      r.answer.must_equal "new"
    end

    it "cannot rsvp twice from event" do
      assert_raise ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid do
        @event.rsvp_create!( @user )
        @event.rsvp_create!( @user )
      end
    end

    it "user can say yes" do
      r = @event.rsvp_create!( @user )
      r.say_yes
      r.answer.must_equal "yes"
    end
  end
end
