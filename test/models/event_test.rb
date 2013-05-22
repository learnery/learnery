require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "past" do
    past_event   = Event.create!( :name => "past event",   :starts => Date.today - 10 )
    next_event   = Event.create!( :name => "next event",   :starts => Date.today + 10 )
    future_event = Event.create!( :name => "future event", :starts => Date.today + 30 )

    f = Event.past

    f.must_include past_event
    f.wont_include next_event
    f.wont_include future_event
  end
  test "future" do
    past_event   = Event.create!( :name => "past event",   :starts => Date.today - 10 )
    next_event   = Event.create!( :name => "next event",   :starts => Date.today + 10 )
    future_event = Event.create!( :name => "future event", :starts => Date.today + 30 )

    f = Event.future

    f.wont_include past_event
    f.first.must_equal next_event
    f.must_include future_event
  end
end
