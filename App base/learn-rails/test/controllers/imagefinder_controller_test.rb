require "test_helper"

class ImagefinderControllerTest < ActionDispatch::IntegrationTest
  test "should get app" do
    get imagefinder_app_url
    assert_response :success
  end
end
