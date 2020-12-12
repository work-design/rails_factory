require "application_system_test_case"

class FactoryTaxonsTest < ApplicationSystemTestCase
  setup do
    @factory_admin_factory_taxon = factory_admin_factory_taxons(:one)
  end

  test "visiting the index" do
    visit factory_admin_factory_taxons_url
    assert_selector "h1", text: "Factory Taxons"
  end

  test "creating a Factory taxon" do
    visit factory_admin_factory_taxons_url
    click_on "New Factory Taxon"

    fill_in "Name", with: @factory_admin_factory_taxon.name
    click_on "Create Factory taxon"

    assert_text "Factory taxon was successfully created"
    click_on "Back"
  end

  test "updating a Factory taxon" do
    visit factory_admin_factory_taxons_url
    click_on "Edit", match: :first

    fill_in "Name", with: @factory_admin_factory_taxon.name
    click_on "Update Factory taxon"

    assert_text "Factory taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Factory taxon" do
    visit factory_admin_factory_taxons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Factory taxon was successfully destroyed"
  end
end
