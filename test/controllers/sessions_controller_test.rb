
require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "guest can open login page" do
    get "/login"

    assert_response :success
  end

  test "user can log in with valid credentials" do
    user = User.create!(
      username: "sessions_test_user",
      email: "sessions_test@example.com",
      password: "Password123!",
      password_confirmation: "Password123!"
    )

    post "/login", params: {
      email: user.email,
      password: "Password123!"
    }

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test "user can log out" do
    user = User.create!(
      username: "sessions_logout_user",
      email: "sessions_logout@example.com",
      password: "Password123!",
      password_confirmation: "Password123!"
    )

    post "/login", params: {
      email: user.email,
      password: "Password123!"
    }

    delete "/logout"

    assert_redirected_to "/login"
  end
end
