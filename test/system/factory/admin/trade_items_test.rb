require "application_system_test_case"

class TradeItemsTest < ApplicationSystemTestCase
  setup do
    @factory_admin_trade_item = factory_admin_trade_items(:one)
  end

  test "visiting the index" do
    visit factory_admin_trade_items_url
    assert_selector "h1", text: "Trade Items"
  end

  test "creating a Trade item" do
    visit factory_admin_trade_items_url
    click_on "New Trade Item"

    fill_in "Amount", with: @factory_admin_trade_item.amount
    fill_in "Extra", with: @factory_admin_trade_item.extra
    fill_in "Note", with: @factory_admin_trade_item.note
    fill_in "Number", with: @factory_admin_trade_item.number
    fill_in "Status", with: @factory_admin_trade_item.status
    click_on "Create Trade item"

    assert_text "Trade item was successfully created"
    click_on "Back"
  end

  test "updating a Trade item" do
    visit factory_admin_trade_items_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @factory_admin_trade_item.amount
    fill_in "Extra", with: @factory_admin_trade_item.extra
    fill_in "Note", with: @factory_admin_trade_item.note
    fill_in "Number", with: @factory_admin_trade_item.number
    fill_in "Status", with: @factory_admin_trade_item.status
    click_on "Update Trade item"

    assert_text "Trade item was successfully updated"
    click_on "Back"
  end

  test "destroying a Trade item" do
    visit factory_admin_trade_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trade item was successfully destroyed"
  end
end
