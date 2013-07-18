require 'test_helper'
module Learnery
class PeopleControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  context "public actions" do
    # none!
  end # /context public actions

  context "admin actions should not be publicly availabe" do
    before do
      @person = create(:user)
    end

    it "should not show index" do
      get :index, use_route: :learnery
      assert_response 302
    end

    it "should not get edit" do
      get :edit, use_route: :learnery, id: @person
      assert_response 302
    end

    it "should not update person" do
      patch :update, use_route: :learnery, id: @person, person: { firstname: "bla" }
      assert_response 302
    end

  end # /context admin action not publicly available


  context "admin actions" do
    before do
      @person = create(:user)
      @admin  = create(:admin_user)
      sign_in( @admin )
    end

    it "should show index" do
      get :index, use_route: :learnery
      assert_response :success
    end

    it "should get edit" do
      get :edit, id: @person, use_route: :learnery
      assert_response :success
    end

    it "should update person" do
      patch :update, use_route: :learnery, id: @person, user: { firstname: "bla" }
      assert_redirected_to learnery.people_path
      @person.reload
      assert @person.firstname == "bla"
    end

  end # /context admin actions
end
end
