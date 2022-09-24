require "application_system_test_case"

class RentalAgreementsTest < ApplicationSystemTestCase
  setup do
    @rental_agreement = rental_agreements(:one)
  end

  test "visiting the index" do
    visit rental_agreements_url
    assert_selector "h1", text: "Rental agreements"
  end

  test "should create rental agreement" do
    visit rental_agreements_url
    click_on "New rental agreement"

    check "Status" if @rental_agreement.status
    fill_in "Timestamp end", with: @rental_agreement.timestamp_end
    fill_in "Timestamp start", with: @rental_agreement.timestamp_start
    click_on "Create Rental agreement"

    assert_text "Rental agreement was successfully created"
    click_on "Back"
  end

  test "should update Rental agreement" do
    visit rental_agreement_url(@rental_agreement)
    click_on "Edit this rental agreement", match: :first

    check "Status" if @rental_agreement.status
    fill_in "Timestamp end", with: @rental_agreement.timestamp_end
    fill_in "Timestamp start", with: @rental_agreement.timestamp_start
    click_on "Update Rental agreement"

    assert_text "Rental agreement was successfully updated"
    click_on "Back"
  end

  test "should destroy Rental agreement" do
    visit rental_agreement_url(@rental_agreement)
    click_on "Destroy this rental agreement", match: :first

    assert_text "Rental agreement was successfully destroyed"
  end
end
