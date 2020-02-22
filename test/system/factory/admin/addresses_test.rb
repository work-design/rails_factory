require "application_system_test_case"

class AddressesTest < ApplicationSystemTestCase
  setup do
    @factory_admin_address = factory_admin_addresses(:one)
  end

  test "visiting the index" do
    visit factory_admin_addresses_url
    assert_selector "h1", text: "Addresses"
  end

  test "creating a Address" do
    visit factory_admin_addresses_url
    click_on "New Address"

    fill_in "Area", with: @factory_admin_address.area
    fill_in "Contact", with: @factory_admin_address.contact
    fill_in "Detail", with: @factory_admin_address.detail
    fill_in "Post code", with: @factory_admin_address.post_code
    fill_in "Source", with: @factory_admin_address.source
    fill_in "Tel", with: @factory_admin_address.tel
    click_on "Create Address"

    assert_text "Address was successfully created"
    click_on "Back"
  end

  test "updating a Address" do
    visit factory_admin_addresses_url
    click_on "Edit", match: :first

    fill_in "Area", with: @factory_admin_address.area
    fill_in "Contact", with: @factory_admin_address.contact
    fill_in "Detail", with: @factory_admin_address.detail
    fill_in "Post code", with: @factory_admin_address.post_code
    fill_in "Source", with: @factory_admin_address.source
    fill_in "Tel", with: @factory_admin_address.tel
    click_on "Update Address"

    assert_text "Address was successfully updated"
    click_on "Back"
  end

  test "destroying a Address" do
    visit factory_admin_addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Address was successfully destroyed"
  end
end
