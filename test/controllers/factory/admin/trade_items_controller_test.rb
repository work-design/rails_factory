require 'test_helper'
class Factory::Admin::TradeItemsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @trade_item = create :trade_item
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
      post admin_trade_items_url, params: { }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_trade_item_url(@trade_item)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_trade_item_url(@trade_item)
    assert_response :success
  end

  test 'update ok' do
    patch admin_trade_item_url(@trade_item), params: { }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('TradeItem.count', -1) do
      delete admin_trade_item_url(@trade_item)
    end

    assert_response :success
  end

end
