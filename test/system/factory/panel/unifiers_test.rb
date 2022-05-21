require "application_system_test_case"

class UnifiersTest < ApplicationSystemTestCase
  setup do
    @factory_panel_unifier = factory_panel_unifiers(:one)
  end

  test "visiting the index" do
    visit factory_panel_unifiers_url
    assert_selector "h1", text: "Unifiers"
  end

  test "should create unifier" do
    visit factory_panel_unifiers_url
    click_on "New unifier"

    fill_in "Code", with: @factory_panel_unifier.code
    fill_in "Name", with: @factory_panel_unifier.name
    click_on "Create Unifier"

    assert_text "Unifier was successfully created"
    click_on "Back"
  end

  test "should update Unifier" do
    visit factory_panel_unifier_url(@factory_panel_unifier)
    click_on "Edit this unifier", match: :first

    fill_in "Code", with: @factory_panel_unifier.code
    fill_in "Name", with: @factory_panel_unifier.name
    click_on "Update Unifier"

    assert_text "Unifier was successfully updated"
    click_on "Back"
  end

  test "should destroy Unifier" do
    visit factory_panel_unifier_url(@factory_panel_unifier)
    click_on "Destroy this unifier", match: :first

    assert_text "Unifier was successfully destroyed"
  end
end
