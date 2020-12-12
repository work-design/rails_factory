require "application_system_test_case"

class ProvidersTest < ApplicationSystemTestCase
  setup do
    @factory_panel_provider = factory_panel_providers(:one)
  end

  test "visiting the index" do
    visit factory_panel_providers_url
    assert_selector "h1", text: "Providers"
  end

  test "creating a Provider" do
    visit factory_panel_providers_url
    click_on "New Provider"

    click_on "Create Provider"

    assert_text "Provider was successfully created"
    click_on "Back"
  end

  test "updating a Provider" do
    visit factory_panel_providers_url
    click_on "Edit", match: :first

    click_on "Update Provider"

    assert_text "Provider was successfully updated"
    click_on "Back"
  end

  test "destroying a Provider" do
    visit factory_panel_providers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Provider was successfully destroyed"
  end
end
