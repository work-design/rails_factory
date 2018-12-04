require 'test_helper'

class Wx::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wx_product = wx_products(:one)
  end

  test "should get index" do
    get wx_products_url
    assert_response :success
  end

  test "should get new" do
    get new_wx_product_url
    assert_response :success
  end

  test "should create wx_product" do
    assert_difference('Product.count') do
      post wx_products_url, params: { wx_product: {  } }
    end

    assert_redirected_to wx_product_url(Product.last)
  end

  test "should show wx_product" do
    get wx_product_url(@wx_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_wx_product_url(@wx_product)
    assert_response :success
  end

  test "should update wx_product" do
    patch wx_product_url(@wx_product), params: { wx_product: {  } }
    assert_redirected_to wx_product_url(@wx_product)
  end

  test "should destroy wx_product" do
    assert_difference('Product.count', -1) do
      delete wx_product_url(@wx_product)
    end

    assert_redirected_to wx_products_url
  end
end
