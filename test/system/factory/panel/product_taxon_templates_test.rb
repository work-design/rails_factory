require "application_system_test_case"

class ProductTaxonTemplatesTest < ApplicationSystemTestCase
  setup do
    @factory_panel_taxon_template = factory_panel_taxon_templates(:one)
  end

  test "visiting the index" do
    visit factory_panel_taxon_templates_url
    assert_selector "h1", text: "Product Taxon Templates"
  end

  test "creating a Product taxon template" do
    visit factory_panel_taxon_templates_url
    click_on "New Product Taxon Template"

    fill_in "Name", with: @factory_panel_taxon_template.name
    click_on "Create Product taxon template"

    assert_text "Product taxon template was successfully created"
    click_on "Back"
  end

  test "updating a Product taxon template" do
    visit factory_panel_taxon_templates_url
    click_on "Edit", match: :first

    fill_in "Name", with: @factory_panel_taxon_template.name
    click_on "Update Product taxon template"

    assert_text "Product taxon template was successfully updated"
    click_on "Back"
  end

  test "destroying a Product taxon template" do
    visit factory_panel_taxon_templates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product taxon template was successfully destroyed"
  end
end
