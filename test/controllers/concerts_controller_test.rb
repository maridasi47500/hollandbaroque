require 'test_helper'

class ConcertsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get concerts_show_url
    assert_response :success
  end

  test "should get index" do
    get concerts_index_url
    assert_response :success
  end

end
