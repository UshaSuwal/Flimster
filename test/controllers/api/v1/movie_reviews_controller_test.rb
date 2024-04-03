require "test_helper"

class Api::V1::MovieReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_movie_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_movie_reviews_show_url
    assert_response :success
  end
end
