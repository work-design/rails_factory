require "application_system_test_case"

class ProductPlansTest < ApplicationSystemTestCase
  setup do
    @factory_product_plan = factory_product_plans(:one)
  end

  test "visiting the index" do
    visit factory_product_plans_url
    assert_selector "h1", text: "Product Plans"
  end

  test "creating a Product plan" do
    visit factory_product_plans_url
    click_on "New Product Plan"

    click_on "Create Product plan"

    assert_text "Product plan was successfully created"
    click_on "Back"
  end

  test "updating a Product plan" do
    visit factory_product_plans_url
    click_on "Edit", match: :first

    click_on "Update Product plan"

    assert_text "Product plan was successfully updated"
    click_on "Back"
  end

  test "destroying a Product plan" do
    visit factory_product_plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product plan was successfully destroyed"
  end
end
