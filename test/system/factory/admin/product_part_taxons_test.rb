require "application_system_test_case"

class ProductPartTaxonsTest < ApplicationSystemTestCase
  setup do
    @factory_admin_taxon_component = factory_admin_taxon_components(:one)
  end

  test "visiting the index" do
    visit factory_admin_taxon_components_url
    assert_selector "h1", text: "Product Part Taxons"
  end

  test "creating a Product part taxon" do
    visit factory_admin_taxon_components_url
    click_on "New Product Part Taxon"

    fill_in "Max select", with: @factory_admin_taxon_component.max_select
    fill_in "Min select", with: @factory_admin_taxon_component.min_select
    fill_in "Name", with: @factory_admin_taxon_component.name
    click_on "Create Product part taxon"

    assert_text "Product part taxon was successfully created"
    click_on "Back"
  end

  test "updating a Product part taxon" do
    visit factory_admin_taxon_components_url
    click_on "Edit", match: :first

    fill_in "Max select", with: @factory_admin_taxon_component.max_select
    fill_in "Min select", with: @factory_admin_taxon_component.min_select
    fill_in "Name", with: @factory_admin_taxon_component.name
    click_on "Update Product part taxon"

    assert_text "Product part taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Product part taxon" do
    visit factory_admin_taxon_components_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product part taxon was successfully destroyed"
  end
end
