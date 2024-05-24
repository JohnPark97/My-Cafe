require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get category_edit_url
    assert_response :success
  end
end
