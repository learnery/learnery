require 'test_helper'

class RsvpTest < ActiveSupport::TestCase

  context "can find" do

    before do
      @r1 = create(:open_rsvp_1)
      @r2 = create(:open_rsvp_2)
    end

    it "all yes-rsvps" do
      Learnery::Rsvp.yes.must_include( @r1 )
      Learnery::Rsvp.yes.wont_include( @r2 )
    end
    it "all no-rsvps" do
      Learnery::Rsvp.no.wont_include( @r1 )
      Learnery::Rsvp.no.must_include( @r2 )
    end

  end

  context "can rsvp" do
    before do
      @event = create(:event)
      @user = create(:user_sequence)
    end


    it " answer defaults to nil" do
      r = Learnery::Rsvp.new( :user => @user, :event => @event )
      r.save!
      r.answer.must_equal nil
    end

    it "but cannot rsvp twice" do
      assert_raise ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid do
        Learnery::Rsvp.create!( :user => @user, :event => @event )
        Learnery::Rsvp.create!( :user => @user, :event => @event )
      end
    end

  end
end
