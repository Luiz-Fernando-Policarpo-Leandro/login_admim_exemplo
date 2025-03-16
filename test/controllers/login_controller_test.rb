require "test_helper"

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get nome:string" do
    get login_nome:string_url
    assert_response :success
  end

  test "should get senha:string" do
    get login_senha:string_url
    assert_response :success
  end
end
