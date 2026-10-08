require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "movie? returns true for movie items" do
    item = Item.new(
      title: "Interstellar",
      item_type: "movie",
      release_year: 2014
    )

    assert item.movie?
    assert_not item.game?
    assert_not item.book?
  end

  test "game? returns true for game items" do
    item = Item.new(
      title: "The Witcher 3",
      item_type: "game",
      release_year: 2015
    )

    assert item.game?
    assert_not item.movie?
    assert_not item.book?
  end

  test "book? returns true for book items" do
    item = Item.new(
      title: "Dune",
      item_type: "book",
      release_year: 1965
    )

    assert item.book?
    assert_not item.movie?
    assert_not item.game?
  end
end
