require 'test_helper'

class TaslsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tasls_index_url
    assert_response :success
  end

end
