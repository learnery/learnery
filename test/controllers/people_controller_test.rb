require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  context "public actions" do
    # none!
  end # /context public actions

  context "admin actions should not be publicly availabe" do
    before do
      @person = User.create!( :email => 'user1@example.com', :password => '12345678')
    end

    it "should not show index" do
      get :index
      assert_response 302
    end

    it "should not get edit" do
      get :edit, id: @person
      assert_response 302
    end

    it "should not update person" do
      patch :update, id: @person, person: { firstname: "bla" }
      assert_response 302
    end

  end # /context admin action not publicly available


  context "admin actions" do
    before do
      @person = User.create!( :email => 'user1@example.com', :password => '12345678')
      @admin  = User.create!( :email => 'user2@example.com', :password => '12345678', :admin => true)
      sign_in( @admin )
    end

    it "should show index" do
      get :index
      assert_response :success
    end

    it "should get edit" do
      get :edit, id: @person
      assert_response :success
    end

    it "should update person" do
      patch :update, id: @person, user: { firstname: "bla" }
      assert_redirected_to people_path
      @person.reload
      assert @person.firstname == "bla"
    end

  end # /context admin actions
end
