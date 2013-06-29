require 'test_helper'
module Learnery
class PagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :show, use_route: :learnery, id: "about"
    assert_response :success
  end
end
end
