require "test_helper"

class UiCatalogueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ui_catalogue_index_url
    assert_response :success
  end
end
