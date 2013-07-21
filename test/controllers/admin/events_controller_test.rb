require 'test_helper'
module Learnery
  module Admin
    class EventsControllerTest < ActionController::TestCase
      include Devise::TestHelpers

      before do
        @event = create(:event)
      end

      context "no actions should be publicly availabe" do
        it "should get index" do
          get :index, use_route: :learnery
          assert_response 302
        end

        it "should show event" do
          get :show, use_route: :learnery, id: @event
          assert_response 302
        end

        it "should destroy event" do
          delete :destroy, use_route: :learnery, id: @event
          assert_response 302
        end

      end # /context admin action not publicly available



      context "admin actions" do
        before do
          u1 = create( :admin_user )
          sign_in( u1 )
        end

        it "should get index" do
          get :index, use_route: :learnery
          assert_response :success
          assert_not_nil assigns(:events)
        end

        it "should show event" do
          get :show, use_route: :learnery, id: @event
          assert_response :success
        end

        it "should destroy event" do
          assert_difference('Event.count', -1) do
            delete :destroy, use_route: :learnery, id: @event
          end
          assert_redirected_to learnery.events_path
        end

      end # /context admin actions
    end
  end
end
