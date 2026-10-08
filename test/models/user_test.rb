require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "rated_items returns only items with ratings" do
    user = User.create!(
      username: "test_user",
      email: "user@example.com",
      password: "password"
    )

    rated_item = Item.create!(
      title: "Rated Movie",
      item_type: "movie",
      release_year: 2024
    )

    unrated_item = Item.create!(
      title: "Unrated Game",
      item_type: "game",
      release_year: 2023
    )

    UserItem.create!(
      user: user,
      item: rated_item,
      status: "completed",
      rating: 9
    )

    UserItem.create!(
      user: user,
      item: unrated_item,
      status: "want"
    )

    assert_equal [ rated_item ], user.rated_items
  end

  test "average_rating returns the average of ratings" do
    user = User.create!(
      username: "test_user",
      email: "user@example.com",
      password: "password"
    )

    item1 = Item.create!(
      title: "Movie 1",
      item_type: "movie",
      release_year: 2024
    )

    item2 = Item.create!(
      title: "Movie 2",
      item_type: "movie",
      release_year: 2023
    )

    UserItem.create!(
      user: user,
      item: item1,
      status: "completed",
      rating: 8
    )

    UserItem.create!(
      user: user,
      item: item2,
      status: "completed",
      rating: 10
    )

    assert_equal 9.0, user.average_rating
  end

  test "average_rating returns nil when user has no ratings" do
    user = User.create!(
      username: "test_user",
      email: "user@example.com",
      password: "password"
    )

    assert_nil user.average_rating
  end
end
