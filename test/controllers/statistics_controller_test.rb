
require "test_helper"

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  test "guest is redirected to login" do
    get statistics_path

    assert_redirected_to "/login"
  end

  test "logged in user can view statistics" do
    user = User.create!(
      username: "statistics_test_user",
      email: "statistics_test@example.com",
      password: "Password123!",
      password_confirmation: "Password123!"
    )

    post "/login", params: {
      email: user.email,
      password: "Password123!"
    }

    get statistics_path

    assert_response :success
  end
end
