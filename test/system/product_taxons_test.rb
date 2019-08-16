require "application_system_test_case"

class ProductTaxonsTest < ApplicationSystemTestCase
  setup do
    @product_taxon = product_taxons(:one)
  end

  test "visiting the index" do
    visit product_taxons_url
    assert_selector "h1", text: "Product Taxons"
  end

  test "creating a Product taxon" do
    visit product_taxons_url
    click_on "New Product Taxon"

    fill_in "Logo", with: @product_taxon.logo
    fill_in "Name", with: @product_taxon.name
    click_on "Create Product taxon"

    assert_text "Product taxon was successfully created"
    click_on "Back"
  end

  test "updating a Product taxon" do
    visit product_taxons_url
    click_on "Edit", match: :first

    fill_in "Logo", with: @product_taxon.logo
    fill_in "Name", with: @product_taxon.name
    click_on "Update Product taxon"

    assert_text "Product taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Product taxon" do
    visit product_taxons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product taxon was successfully destroyed"
  end
end
