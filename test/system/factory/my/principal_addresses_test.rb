require "application_system_test_case"

class PrincipalAddressesTest < ApplicationSystemTestCase
  setup do
    @factory_my_principal_address = factory_my_principal_addresses(:one)
  end

  test "visiting the index" do
    visit factory_my_principal_addresses_url
    assert_selector "h1", text: "Principal Addresses"
  end

  test "creating a Principal address" do
    visit factory_my_principal_addresses_url
    click_on "New Principal Address"

    click_on "Create Principal address"

    assert_text "Principal address was successfully created"
    click_on "Back"
  end

  test "updating a Principal address" do
    visit factory_my_principal_addresses_url
    click_on "Edit", match: :first

    click_on "Update Principal address"

    assert_text "Principal address was successfully updated"
    click_on "Back"
  end

  test "destroying a Principal address" do
    visit factory_my_principal_addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Principal address was successfully destroyed"
  end
end
