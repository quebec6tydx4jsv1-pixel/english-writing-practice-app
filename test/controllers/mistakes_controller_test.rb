require "test_helper"

class MistakesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mistakes_index_url
    assert_response :success
  end
end
