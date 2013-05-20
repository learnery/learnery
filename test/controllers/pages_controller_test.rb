require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :show, id: "about"
    assert_response :success
  end
end
