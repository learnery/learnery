require 'test_helper'

class RsvpTest < ActiveSupport::TestCase

  context "can find" do

    before do
      @r1 = create(:rsvp, answer: :yes)
      @r2 = create(:rsvp, answer: :no)
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

  context "can give implementations" do
    it " answer defaults to nil" do
      i = Learnery::Rsvp.implementations
      i.count.must_equal 3
    end
  end
end
