require "application_system_test_case"

class LeaseholdersTest < ApplicationSystemTestCase
  setup do
    @leaseholder = leaseholders(:one)
  end

  test "visiting the index" do
    visit leaseholders_url
    assert_selector "h1", text: "Leaseholders"
  end

  test "should create leaseholder" do
    visit leaseholders_url
    click_on "New leaseholder"

    fill_in "Credit", with: @leaseholder.credit
    fill_in "Id picture back", with: @leaseholder.id_picture_back
    fill_in "Id picture front", with: @leaseholder.id_picture_front
    fill_in "Mean reviews", with: @leaseholder.mean_reviews
    fill_in "Polygon", with: @leaseholder.polygon
    fill_in "Property account", with: @leaseholder.property_account
    check "Status" if @leaseholder.status
    click_on "Create Leaseholder"

    assert_text "Leaseholder was successfully created"
    click_on "Back"
  end

  test "should update Leaseholder" do
    visit leaseholder_url(@leaseholder)
    click_on "Edit this leaseholder", match: :first

    fill_in "Credit", with: @leaseholder.credit
    fill_in "Id picture back", with: @leaseholder.id_picture_back
    fill_in "Id picture front", with: @leaseholder.id_picture_front
    fill_in "Mean reviews", with: @leaseholder.mean_reviews
    fill_in "Polygon", with: @leaseholder.polygon
    fill_in "Property account", with: @leaseholder.property_account
    check "Status" if @leaseholder.status
    click_on "Update Leaseholder"

    assert_text "Leaseholder was successfully updated"
    click_on "Back"
  end

  test "should destroy Leaseholder" do
    visit leaseholder_url(@leaseholder)
    click_on "Destroy this leaseholder", match: :first

    assert_text "Leaseholder was successfully destroyed"
  end
end
