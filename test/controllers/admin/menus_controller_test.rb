require "test_helper"

class Admin::MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_menus_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_menus_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_menus_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_menus_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_menus_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_menus_destroy_url
    assert_response :success
  end
end
