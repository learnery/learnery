require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  before do
    @event = events(:one)
  end

  context "public actions" do

    it "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:events)
    end

    it "should show event" do
      get :show, id: @event
      assert_response :success
    end

  end # /context public actions

  context "admin actions should not be publicly availabe" do

    it "should get new" do
      get :new
      assert_response 302
    end

    it "should create event" do
      post :create, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue }
      assert_response 302
    end

    it "should get edit" do
      get :edit, id: @event
      assert_response 302
    end

    it "should update event" do
      patch :update, id: @event, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue }
      assert_response 302
    end

  end # /context admin action not publicly available



  context "admin actions" do
    before do
      u1 = User.create!( :email => 'user1@example.com', :password => '12345678', :admin => true)
      sign_in( u1 )
    end

    it "should get new" do
      get :new
      assert_response :success
    end

    it "should create event" do
      assert_difference('Event.count') do
        post :create, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue }
      end

      assert_redirected_to event_path(assigns(:event))
    end

    it "should get edit" do
      get :edit, id: @event
      assert_response :success
    end

    it "should update event" do
      patch :update, id: @event, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue }
      assert_redirected_to event_path(assigns(:event))
    end

  end # /context admin actions
end
