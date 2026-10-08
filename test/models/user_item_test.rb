require "test_helper"

class UserItemTest < ActiveSupport::TestCase
  test "rated? returns true when item has a rating" do
    user_item = UserItem.new(
      status: "completed",
      rating: 9
    )

    assert user_item.rated?
  end

  test "rated? returns false when item has no rating" do
    user_item = UserItem.new(
      status: "want",
      rating: nil
    )

    assert_not user_item.rated?
  end

  test "completed? returns true only for completed status" do
    completed_item = UserItem.new(status: "completed")
    want_item = UserItem.new(status: "want")
    in_progress_item = UserItem.new(status: "in_progress")

    assert completed_item.completed?
    assert_not want_item.completed?
    assert_not in_progress_item.completed?
  end
end
