require 'test_helper'

class ListenControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get listen_show_url
    assert_response :success
  end

  test "should get index" do
    get listen_index_url
    assert_response :success
  end

end
