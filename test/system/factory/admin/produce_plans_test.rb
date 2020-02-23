require "application_system_test_case"

class ProducePlansTest < ApplicationSystemTestCase
  setup do
    @factory_admin_produce_plan = factory_admin_produce_plans(:one)
  end

  test "visiting the index" do
    visit factory_admin_produce_plans_url
    assert_selector "h1", text: "Produce Plans"
  end

  test "creating a Produce plan" do
    visit factory_admin_produce_plans_url
    click_on "New Produce Plan"

    fill_in "Finish at", with: @factory_admin_produce_plan.finish_at
    fill_in "Start at", with: @factory_admin_produce_plan.start_at
    fill_in "State", with: @factory_admin_produce_plan.state
    fill_in "Title", with: @factory_admin_produce_plan.title
    click_on "Create Produce plan"

    assert_text "Produce plan was successfully created"
    click_on "Back"
  end

  test "updating a Produce plan" do
    visit factory_admin_produce_plans_url
    click_on "Edit", match: :first

    fill_in "Finish at", with: @factory_admin_produce_plan.finish_at
    fill_in "Start at", with: @factory_admin_produce_plan.start_at
    fill_in "State", with: @factory_admin_produce_plan.state
    fill_in "Title", with: @factory_admin_produce_plan.title
    click_on "Update Produce plan"

    assert_text "Produce plan was successfully updated"
    click_on "Back"
  end

  test "destroying a Produce plan" do
    visit factory_admin_produce_plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Produce plan was successfully destroyed"
  end
end
