require "application_system_test_case"

class FitsTest < ApplicationSystemTestCase
  setup do
    @factory_admin_fit = factory_admin_fits(:one)
  end

  test "visiting the index" do
    visit factory_admin_fits_url
    assert_selector "h1", text: "Fits"
  end

  test "should create fit" do
    visit factory_admin_fits_url
    click_on "New fit"

    fill_in "Part brand", with: @factory_admin_fit.part_brand_id
    fill_in "Part product", with: @factory_admin_fit.part_product_id
    fill_in "Part production", with: @factory_admin_fit.part_production_id
    fill_in "Part serial", with: @factory_admin_fit.part_serial_id
    click_on "Create Fit"

    assert_text "Fit was successfully created"
    click_on "Back"
  end

  test "should update Fit" do
    visit factory_admin_fit_url(@factory_admin_fit)
    click_on "Edit this fit", match: :first

    fill_in "Part brand", with: @factory_admin_fit.part_brand_id
    fill_in "Part product", with: @factory_admin_fit.part_product_id
    fill_in "Part production", with: @factory_admin_fit.part_production_id
    fill_in "Part serial", with: @factory_admin_fit.part_serial_id
    click_on "Update Fit"

    assert_text "Fit was successfully updated"
    click_on "Back"
  end

  test "should destroy Fit" do
    visit factory_admin_fit_url(@factory_admin_fit)
    click_on "Destroy this fit", match: :first

    assert_text "Fit was successfully destroyed"
  end
end
