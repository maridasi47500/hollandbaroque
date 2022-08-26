require 'test_helper'

class OveronsControllerTest < ActionDispatch::IntegrationTest
  test "should get partners" do
    get overons_partners_url
    assert_response :success
  end

  test "should get perskit" do
    get overons_perskit_url
    assert_response :success
  end

end
