require "application_system_test_case"

class BrandsTest < ApplicationSystemTestCase
  setup do
    @factory_admin_brand = factory_admin_brands(:one)
  end

  test "visiting the index" do
    visit factory_admin_brands_url
    assert_selector "h1", text: "Brands"
  end

  test "should create brand" do
    visit factory_admin_brands_url
    click_on "New brand"

    fill_in "Logo", with: @factory_admin_brand.logo
    fill_in "Name", with: @factory_admin_brand.name
    click_on "Create Brand"

    assert_text "Brand was successfully created"
    click_on "Back"
  end

  test "should update Brand" do
    visit factory_admin_brand_url(@factory_admin_brand)
    click_on "Edit this brand", match: :first

    fill_in "Logo", with: @factory_admin_brand.logo
    fill_in "Name", with: @factory_admin_brand.name
    click_on "Update Brand"

    assert_text "Brand was successfully updated"
    click_on "Back"
  end

  test "should destroy Brand" do
    visit factory_admin_brand_url(@factory_admin_brand)
    click_on "Destroy this brand", match: :first

    assert_text "Brand was successfully destroyed"
  end
end
