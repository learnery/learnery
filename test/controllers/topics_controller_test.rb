require 'test_helper'
module Learnery
class TopicsControllerTest < ActionController::TestCase
include Devise::TestHelpers

  before do
    @event = create(:event)
    @topic = create(:topic, :event => @event)
  end
  context "public actions" do
    it "should get index" do
      get :index, use_route: :learnery
      assert_response :success
      assert_not_nil assigns(:topics)
    end

    it "should not get new" do
      get :new, use_route: :learnery
      assert_response :redirect
    end
    test "should not get edit" do
      get :edit, use_route: :learnery, id: @topic
      assert_response :redirect
    end
    test "should show topic" do
      get :show, use_route: :learnery, id: @topic
      assert_response :success
    end
  end
  context "logged in user" do
    before do
      @user = create(:user)
      sign_in( @user )
    end
    it "should get new" do
      get :new, use_route: :learnery, use_route: :learnery
      assert_response :success
    end
    test "should create topic" do
      assert_difference('Topic.count') do
        post :create, use_route: :learnery, topic: { description: @topic.description, event_id: @topic.event_id, name: @topic.name, presented_by_id: @topic.presented_by_id, suggested_by_id: @topic.suggested_by_id }
      end

      assert_redirected_to learnery.event_path(assigns(:topic).event)
    end
    test "should get edit" do
      get :edit, use_route: :learnery, id: @topic
      assert_response :success
    end
    test "should update topic" do
      patch :update, use_route: :learnery, id: @topic, topic: { description: @topic.description, event_id: @topic.event_id, name: @topic.name, presented_by_id: @topic.presented_by_id, suggested_by_id: @topic.suggested_by_id }
      assert_redirected_to learnery.topic_path(assigns(:topic))
    end

    test "should destroy topic" do
      assert_difference('Topic.count', -1) do
        delete :destroy, use_route: :learnery, id: @topic
      end

      assert_redirected_to learnery.topics_path
    end
  end
end
end
