
require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "guest can open registration page" do
    get "/register"

    assert_response :success
  end

  test "user can register with valid details" do
    assert_difference("User.count", 1) do
      post "/register", params: {
        user: {
          username: "registration_test_user",
          email: "registration_test@example.com",
          password: "Password123!",
          password_confirmation: "Password123!"
        }
      }
    end

    assert_redirected_to "/register"
  end
end
