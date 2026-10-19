
require "test_helper"

class UiCatalogueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/uicatalogue"

    assert_response :success
  end
end
