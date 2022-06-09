require "test_helper"

class CheckInsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get check_ins_index_url
    assert_response :success
  end

  test "should get create" do
    get check_ins_create_url
    assert_response :success
  end

  test "should get destroy" do
    get check_ins_destroy_url
    assert_response :success
  end
end
