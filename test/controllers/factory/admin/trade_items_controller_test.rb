require 'test_helper'
class Factory::Admin::TradeItemsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_admin_trade_item = create factory_admin_trade_items
  end

  test 'index ok' do
    get admin_trade_items_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_trade_item_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('TradeItem.count') do
      post admin_trade_items_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_trade_item_url(@factory_admin_trade_item)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_trade_item_url(@factory_admin_trade_item)
    assert_response :success
  end

  test 'update ok' do
    patch admin_trade_item_url(@factory_admin_trade_item), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('TradeItem.count', -1) do
      delete admin_trade_item_url(@factory_admin_trade_item)
    end

    assert_response :success
  end

end
