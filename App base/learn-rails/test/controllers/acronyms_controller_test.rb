require "test_helper"

class AcronymsControllerTest < ActionDispatch::IntegrationTest
  test "should get app" do
    get acronyms_app_url
    assert_response :success
  end
end
