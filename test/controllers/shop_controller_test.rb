require 'test_helper'

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shop_show_url
    assert_response :success
  end

  test "should get index" do
    get shop_index_url
    assert_response :success
  end

end
