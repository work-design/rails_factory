require "application_system_test_case"

class TradeItemsTest < ApplicationSystemTestCase
  setup do
    @factory_my_trade_item = factory_my_trade_items(:one)
  end

  test "visiting the index" do
    visit factory_my_trade_items_url
    assert_selector "h1", text: "Trade Items"
  end

  test "creating a Trade item" do
    visit factory_my_trade_items_url
    click_on "New Trade Item"

    click_on "Create Trade item"

    assert_text "Trade item was successfully created"
    click_on "Back"
  end

  test "updating a Trade item" do
    visit factory_my_trade_items_url
    click_on "Edit", match: :first

    click_on "Update Trade item"

    assert_text "Trade item was successfully updated"
    click_on "Back"
  end

  test "destroying a Trade item" do
    visit factory_my_trade_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trade item was successfully destroyed"
  end
end
