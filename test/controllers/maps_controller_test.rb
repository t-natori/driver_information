require "test_helper"

class MapsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get maps_top_url
    assert_response :success
  end
end
