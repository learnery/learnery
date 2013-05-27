require 'test_helper'

class RsvpTest < ActiveSupport::TestCase

  context "can find" do

    before do
      @event = Event.create!( :name => 'intresting event', :starts => Date.today + 10 )
      @u1 = User.create!( :email => 'user1@example.com', :password => '12345678')
      @u2 = User.create!( :email => 'user2@example.com', :password => '12345678')
      @r1 = Rsvp.create!( :user => @u1, :event => @event )
      @r2 = Rsvp.create!( :user => @u2, :event => @event, :answer => :no )
    end

    it "all yes-rsvps" do
      Rsvp.yes.must_include( @r1 )
      Rsvp.yes.wont_include( @r2 )
    end
    it "all no-rsvps" do
      Rsvp.no.wont_include( @r1 )
      Rsvp.no.must_include( @r2 )
    end

  end

  context "can rsvp" do
    before do
      @event = Event.create!( :name => 'intresting event', :starts => Date.today + 10 )
      @user = User.create!( :email => 'user@example.com', :password => '12345678')
    end


    it " answer defaults to yes" do
      r = Rsvp.new( :user => @user, :event => @event )
      r.save!
      r.answer.must_equal "yes"
    end

    it "but cannot rsvp twice" do
      assert_raise ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid do
        Rsvp.create!( :user => @user, :event => @event )
        Rsvp.create!( :user => @user, :event => @event )
      end
    end

  end
end
