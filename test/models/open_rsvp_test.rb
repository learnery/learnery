require 'test_helper'

class OpenRsvpTest < ActiveSupport::TestCase

  context "can rsvp" do
    before do
      @event = Event.create!( :name => 'intresting event', :starts => Date.today + 10 )
      @user  = User.create!( :email => 'user@example.com', :password => '12345678')
    end

    it "answer defaults to yes" do
      r = OpenRsvp.new( :user => @user, :event => @event )
      r.save!
      r.answer.must_equal "yes"
    end

    it "but cannot rsvp twice" do
      assert_raise ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid do
        OpenRsvp.create!( :user => @user, :event => @event )
        OpenRsvp.create!( :user => @user, :event => @event )
      end
    end

  end
end
