require "application_system_test_case"

class CustomsTest < ApplicationSystemTestCase
  setup do
    @custom = customs(:one)
  end

  test "visiting the index" do
    visit customs_url
    assert_selector "h1", text: "Customs"
  end

  test "creating a Custom" do
    visit customs_url
    click_on "New Custom"

    fill_in "Customer", with: @custom.customer
    fill_in "Name", with: @custom.name
    fill_in "Ordered At", with: @custom.ordered_at
    fill_in "Qr Code", with: @custom.qr_code
    fill_in "State", with: @custom.state
    click_on "Create Custom"

    assert_text "Custom was successfully created"
    click_on "Back"
  end

  test "updating a Custom" do
    visit customs_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @custom.customer
    fill_in "Name", with: @custom.name
    fill_in "Ordered At", with: @custom.ordered_at
    fill_in "Qr Code", with: @custom.qr_code
    fill_in "State", with: @custom.state
    click_on "Update Custom"

    assert_text "Custom was successfully updated"
    click_on "Back"
  end

  test "destroying a Custom" do
    visit customs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Custom was successfully destroyed"
  end
end
