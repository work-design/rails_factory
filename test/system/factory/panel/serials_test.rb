require "application_system_test_case"

class SerialsTest < ApplicationSystemTestCase
  setup do
    @factory_panel_serial = factory_panel_serials(:one)
  end

  test "visiting the index" do
    visit factory_panel_serials_url
    assert_selector "h1", text: "Serials"
  end

  test "should create serial" do
    visit factory_panel_serials_url
    click_on "New serial"

    fill_in "Name", with: @factory_panel_serial.name
    click_on "Create Serial"

    assert_text "Serial was successfully created"
    click_on "Back"
  end

  test "should update Serial" do
    visit factory_panel_serial_url(@factory_panel_serial)
    click_on "Edit this serial", match: :first

    fill_in "Name", with: @factory_panel_serial.name
    click_on "Update Serial"

    assert_text "Serial was successfully updated"
    click_on "Back"
  end

  test "should destroy Serial" do
    visit factory_panel_serial_url(@factory_panel_serial)
    click_on "Destroy this serial", match: :first

    assert_text "Serial was successfully destroyed"
  end
end
