require 'test_helper'

class EtpageControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get etpage_show_url
    assert_response :success
  end

  test "should get index" do
    get etpage_index_url
    assert_response :success
  end

end
