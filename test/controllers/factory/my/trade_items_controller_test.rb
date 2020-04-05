require 'test_helper'
class Factory::My::TradeItemsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @trade_item = create :trade_item
  end

  test 'index ok' do
    get my_trade_items_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_trade_item_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('TradeItem.count') do
      post my_trade_items_url, params: { }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_trade_item_url(@trade_item)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_trade_item_url(@trade_item)
    assert_response :success
  end

  test 'update ok' do
    patch my_trade_item_url(@trade_item), params: { }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('TradeItem.count', -1) do
      delete my_trade_item_url(@trade_item)
    end

    assert_response :success
  end

end
