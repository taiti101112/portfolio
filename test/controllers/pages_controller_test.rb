require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get privacy_policy" do
    get pages_privacy_policy_url
    assert_response :success
  end

  test "should get terms_of_service" do
    get pages_terms_of_service_url
    assert_response :success
  end

  test "should get contact" do
    get pages_contact_url
    assert_response :success
  end
end
