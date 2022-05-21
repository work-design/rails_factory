require "application_system_test_case"

class ProvidesTest < ApplicationSystemTestCase
  setup do
    @factory_admin_provide = factory_admin_provides(:one)
  end

  test "visiting the index" do
    visit factory_admin_provides_url
    assert_selector "h1", text: "Provides"
  end

  test "should create provide" do
    visit factory_admin_provides_url
    click_on "New provide"

    fill_in "Provider", with: @factory_admin_provide.provider_id
    click_on "Create Provide"

    assert_text "Provide was successfully created"
    click_on "Back"
  end

  test "should update Provide" do
    visit factory_admin_provide_url(@factory_admin_provide)
    click_on "Edit this provide", match: :first

    fill_in "Provider", with: @factory_admin_provide.provider_id
    click_on "Update Provide"

    assert_text "Provide was successfully updated"
    click_on "Back"
  end

  test "should destroy Provide" do
    visit factory_admin_provide_url(@factory_admin_provide)
    click_on "Destroy this provide", match: :first

    assert_text "Provide was successfully destroyed"
  end
end
