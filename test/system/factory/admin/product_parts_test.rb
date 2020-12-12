require "application_system_test_case"

class ProductPartsTest < ApplicationSystemTestCase
  setup do
    @factory_admin_product_part = factory_admin_product_parts(:one)
  end

  test "visiting the index" do
    visit factory_admin_product_parts_url
    assert_selector "h1", text: "Product Parts"
  end

  test "creating a Product part" do
    visit factory_admin_product_parts_url
    click_on "New Product Part"

    fill_in "Default", with: @factory_admin_product_part.default
    fill_in "Part", with: @factory_admin_product_part.part_id
    fill_in "Part taxon", with: @factory_admin_product_part.part_taxon_id
    click_on "Create Product part"

    assert_text "Product part was successfully created"
    click_on "Back"
  end

  test "updating a Product part" do
    visit factory_admin_product_parts_url
    click_on "Edit", match: :first

    fill_in "Default", with: @factory_admin_product_part.default
    fill_in "Part", with: @factory_admin_product_part.part_id
    fill_in "Part taxon", with: @factory_admin_product_part.part_taxon_id
    click_on "Update Product part"

    assert_text "Product part was successfully updated"
    click_on "Back"
  end

  test "destroying a Product part" do
    visit factory_admin_product_parts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product part was successfully destroyed"
  end
end
