require 'test_helper'

class SiteControllerTest < ActionDispatch::IntegrationTest
  test "should get educationtalent" do
    get site_educationtalent_url
    assert_response :success
  end

end
