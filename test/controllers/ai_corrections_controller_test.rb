require "test_helper"

class AiCorrectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get ai_corrections_create_url
    assert_response :success
  end
end
