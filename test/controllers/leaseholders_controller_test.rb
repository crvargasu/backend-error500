require "test_helper"

class LeaseholdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leaseholder = leaseholders(:one)
  end

  test "should get index" do
    get leaseholders_url
    assert_response :success
  end

  test "should get new" do
    get new_leaseholder_url
    assert_response :success
  end

  test "should create leaseholder" do
    assert_difference("Leaseholder.count") do
      post leaseholders_url, params: { leaseholder: { credit: @leaseholder.credit, id_picture_back: @leaseholder.id_picture_back, id_picture_front: @leaseholder.id_picture_front, mean_reviews: @leaseholder.mean_reviews, polygon: @leaseholder.polygon, property_account: @leaseholder.property_account, status: @leaseholder.status } }
    end

    assert_redirected_to leaseholder_url(Leaseholder.last)
  end

  test "should show leaseholder" do
    get leaseholder_url(@leaseholder)
    assert_response :success
  end

  test "should get edit" do
    get edit_leaseholder_url(@leaseholder)
    assert_response :success
  end

  test "should update leaseholder" do
    patch leaseholder_url(@leaseholder), params: { leaseholder: { credit: @leaseholder.credit, id_picture_back: @leaseholder.id_picture_back, id_picture_front: @leaseholder.id_picture_front, mean_reviews: @leaseholder.mean_reviews, polygon: @leaseholder.polygon, property_account: @leaseholder.property_account, status: @leaseholder.status } }
    assert_redirected_to leaseholder_url(@leaseholder)
  end

  test "should destroy leaseholder" do
    assert_difference("Leaseholder.count", -1) do
      delete leaseholder_url(@leaseholder)
    end

    assert_redirected_to leaseholders_url
  end
end
