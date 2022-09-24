require "application_system_test_case"

class LessorsTest < ApplicationSystemTestCase
  setup do
    @lessor = lessors(:one)
  end

  test "visiting the index" do
    visit lessors_url
    assert_selector "h1", text: "Lessors"
  end

  test "should create lessor" do
    visit lessors_url
    click_on "New lessor"

    fill_in "Credit", with: @lessor.credit
    fill_in "Mean reviews", with: @lessor.mean_reviews
    click_on "Create Lessor"

    assert_text "Lessor was successfully created"
    click_on "Back"
  end

  test "should update Lessor" do
    visit lessor_url(@lessor)
    click_on "Edit this lessor", match: :first

    fill_in "Credit", with: @lessor.credit
    fill_in "Mean reviews", with: @lessor.mean_reviews
    click_on "Update Lessor"

    assert_text "Lessor was successfully updated"
    click_on "Back"
  end

  test "should destroy Lessor" do
    visit lessor_url(@lessor)
    click_on "Destroy this lessor", match: :first

    assert_text "Lessor was successfully destroyed"
  end
end
