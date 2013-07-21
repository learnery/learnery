require 'test_helper'
module Learnery
class EventsControllerTest < ActionController::TestCase

  before do
    @event = create(:event)
  end

  context "public actions" do

    it "should get index" do
      get :index, use_route: :learnery
      assert_response :success
      assert_not_nil assigns(:events)
    end

    it "should show event" do
      get :show, id: @event, use_route: :learnery
      assert_response :success
    end

  end # /context public actions

  context "admin actions should not be publicly availabe" do

    it "should get new" do
      get :new, use_route: :learnery
      assert_response 302
    end

    it "should create event" do
      post :create, use_route: :learnery, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue }
      assert_response 302
    end

    it "should get edit" do
      get :edit, use_route: :learnery, id: @event
      assert_response 302
    end

    it "should update event" do
      patch :update, use_route: :learnery, id: @event, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue }
      assert_response 302
    end

  end # /context admin action not publicly available



  context "admin actions" do
    before do
      #u1 = User.create!( :email => 'user1@example.com', :password => '12345678', :admin => true)
      u1 = create(:admin_user)
      sign_in( u1 )
    end

    it "should get new" do
      get :new, use_route: :learnery
      assert_response :success
    end

    it "should create event" do

      assert_difference('Event.count') do
        post :create, use_route: :learnery, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue, type: @event.type }
      end
      assert_redirected_to learnery.event_path(assigns(:event)), "bla bla"
    end

    it "should get edit" do

      get :edit, use_route: :learnery, id: @event
      assert_response :success
    end

    it "should update event" do
      patch :update, use_route: :learnery, id: @event, event: { description: @event.description, ends: @event.ends, name: @event.name, starts: @event.starts, venue: @event.venue }
      assert_redirected_to learnery.event_path(assigns(:event))
    end

  end # /context admin actions
end
end
