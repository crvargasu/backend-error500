require "test_helper"

class LessorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lessor = lessors(:one)
  end

  test "should get index" do
    get lessors_url
    assert_response :success
  end

  test "should get new" do
    get new_lessor_url
    assert_response :success
  end

  test "should create lessor" do
    assert_difference("Lessor.count") do
      post lessors_url, params: { lessor: { credit: @lessor.credit, mean_reviews: @lessor.mean_reviews } }
    end

    assert_redirected_to lessor_url(Lessor.last)
  end

  test "should show lessor" do
    get lessor_url(@lessor)
    assert_response :success
  end

  test "should get edit" do
    get edit_lessor_url(@lessor)
    assert_response :success
  end

  test "should update lessor" do
    patch lessor_url(@lessor), params: { lessor: { credit: @lessor.credit, mean_reviews: @lessor.mean_reviews } }
    assert_redirected_to lessor_url(@lessor)
  end

  test "should destroy lessor" do
    assert_difference("Lessor.count", -1) do
      delete lessor_url(@lessor)
    end

    assert_redirected_to lessors_url
  end
end
