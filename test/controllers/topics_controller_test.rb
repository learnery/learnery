require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
include Devise::TestHelpers

  before do
    @topic = create(:topic)
  end
  context "public actions" do
    it "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:topics)
    end

    it "should not get new" do
      get :new
      assert_response :redirect
    end
    test "should not get edit" do
      get :edit, id: @topic
      assert_response :redirect
    end
    test "should show topic" do
      get :show, id: @topic
      assert_response :success
    end
  end
  context "logged in user" do
    before do
      @user = create(:user)
      sign_in( @user )
    end
    it "should get new" do
      get :new
      assert_response :success
    end
    test "should create topic" do
      assert_difference('Topic.count') do
        post :create, topic: { description: @topic.description, event_id: @topic.event_id, name: @topic.name, presented_by_id: @topic.presented_by_id, suggested_by_id: @topic.suggested_by_id }
      end

      assert_redirected_to topic_path(assigns(:topic))
    end
    test "should get edit" do
      get :edit, id: @topic
      assert_response :success
    end
        test "should update topic" do
      patch :update, id: @topic, topic: { description: @topic.description, event_id: @topic.event_id, name: @topic.name, presented_by_id: @topic.presented_by_id, suggested_by_id: @topic.suggested_by_id }
      assert_redirected_to topic_path(assigns(:topic))
    end

    test "should destroy topic" do
      assert_difference('Topic.count', -1) do
        delete :destroy, id: @topic
      end

      assert_redirected_to topics_path
    end
  end

end
