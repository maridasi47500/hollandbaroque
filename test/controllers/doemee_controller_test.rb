require 'test_helper'

class DoemeeControllerTest < ActionDispatch::IntegrationTest
  test "should get private" do
    get doemee_private_url
    assert_response :success
  end

  test "should get professional" do
    get doemee_professional_url
    assert_response :success
  end

end
