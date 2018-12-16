require "application_system_test_case"

class CustomsTest < ApplicationSystemTestCase
  setup do
    @wx_custom = wx_customs(:one)
  end

  test "visiting the index" do
    visit wx_customs_url
    assert_selector "h1", text: "Customs"
  end

  test "creating a Custom" do
    visit wx_customs_url
    click_on "New Custom"

    click_on "Create Custom"

    assert_text "Custom was successfully created"
    click_on "Back"
  end

  test "updating a Custom" do
    visit wx_customs_url
    click_on "Edit", match: :first

    click_on "Update Custom"

    assert_text "Custom was successfully updated"
    click_on "Back"
  end

  test "destroying a Custom" do
    visit wx_customs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Custom was successfully destroyed"
  end
end
