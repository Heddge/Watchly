
require "test_helper"

class LibraryWorkflowTest < ActionDispatch::IntegrationTest
  test "user can add a movie, update it, and see it in library" do
    user = User.create!(
      username: "workflow_user",
      email: "workflow@example.com",
      password: "Password123!",
      password_confirmation: "Password123!"
    )

    item = Item.create!(
      title: "Integration Test Movie",
      item_type: "movie",
      release_year: 2020,
      tmdb_rating: 8.5
    )

    # Sign in
    post "/login", params: {
      email: user.email,
      password: "Password123!"
    }

    assert_redirected_to root_path

    # Open catalog
    get "/items"
    assert_response :success
    assert_select "body", /Integration Test Movie/

    # Add movie to personal library
    assert_difference("UserItem.count", 1) do
      post "/user_items", params: { item_id: item.id }
    end

    assert_redirected_to user_items_path

    user_item = UserItem.find_by!(user: user, item: item)
    assert_equal "want", user_item.status

    # Update status and personal rating
    patch "/user_items/#{user_item.id}", params: {
      user_item: {
        status: "completed",
        rating: 9
      }
    }

    assert_redirected_to user_items_path

    user_item.reload
    assert_equal "completed", user_item.status
    assert_equal 9, user_item.rating

    # Verify the movie is visible in the personal library
    get "/user_items"
    assert_response :success
    assert_select "body", /Integration Test Movie/
  end

  test "guest is redirected when opening library and statistics" do
    get "/user_items"

    assert_redirected_to "/login"
    follow_redirect!
    assert_response :success

    get "/statistics"

    assert_redirected_to "/login"
    follow_redirect!
    assert_response :success
  end

    test "user cannot update another user's library entry" do
    owner = User.create!(
      username: "library_owner",
      email: "owner@example.com",
      password: "Password123!",
      password_confirmation: "Password123!"
    )

    other_user = User.create!(
      username: "other_user",
      email: "other@example.com",
      password: "Password123!",
      password_confirmation: "Password123!"
    )

    item = Item.create!(
      title: "Private Library Movie",
      item_type: "movie",
      release_year: 2021,
      tmdb_rating: 7.5
    )

    owned_entry = UserItem.create!(
      user: owner,
      item: item,
      status: "want"
    )

    # Sign in as a different user
    post "/login", params: {
      email: other_user.email,
      password: "Password123!"
    }

    # Try to modify the owner's entry
    assert_no_changes -> { owned_entry.reload.attributes } do
      patch "/user_items/#{owned_entry.id}", params: {
        user_item: {
          status: "completed",
          rating: 10
        }
      }
    end

    assert_response :not_found
  end

    test "adding the same movie twice does not create a duplicate" do
    user = User.create!(
      username: "duplicate_test_user",
      email: "duplicate@example.com",
      password: "Password123!",
      password_confirmation: "Password123!"
    )

    item = Item.create!(
      title: "Duplicate Test Movie",
      item_type: "movie",
      release_year: 2022,
      tmdb_rating: 8.0
    )

    post "/login", params: {
      email: user.email,
      password: "Password123!"
    }

    assert_difference("UserItem.count", 1) do
      post "/user_items", params: { item_id: item.id }
    end

    assert_no_difference("UserItem.count") do
      post "/user_items", params: { item_id: item.id }
    end

    assert_equal 1, user.user_items.where(item: item).count
  end
end
