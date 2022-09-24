require "test_helper"

class RentalAgreementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rental_agreement = rental_agreements(:one)
  end

  test "should get index" do
    get rental_agreements_url
    assert_response :success
  end

  test "should get new" do
    get new_rental_agreement_url
    assert_response :success
  end

  test "should create rental_agreement" do
    assert_difference("RentalAgreement.count") do
      post rental_agreements_url, params: { rental_agreement: { status: @rental_agreement.status, timestamp_end: @rental_agreement.timestamp_end, timestamp_start: @rental_agreement.timestamp_start } }
    end

    assert_redirected_to rental_agreement_url(RentalAgreement.last)
  end

  test "should show rental_agreement" do
    get rental_agreement_url(@rental_agreement)
    assert_response :success
  end

  test "should get edit" do
    get edit_rental_agreement_url(@rental_agreement)
    assert_response :success
  end

  test "should update rental_agreement" do
    patch rental_agreement_url(@rental_agreement), params: { rental_agreement: { status: @rental_agreement.status, timestamp_end: @rental_agreement.timestamp_end, timestamp_start: @rental_agreement.timestamp_start } }
    assert_redirected_to rental_agreement_url(@rental_agreement)
  end

  test "should destroy rental_agreement" do
    assert_difference("RentalAgreement.count", -1) do
      delete rental_agreement_url(@rental_agreement)
    end

    assert_redirected_to rental_agreements_url
  end
end
