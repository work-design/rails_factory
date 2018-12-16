require 'test_helper'

class Wx::CustomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wx_custom = wx_customs(:one)
  end

  test "should get index" do
    get wx_customs_url
    assert_response :success
  end

  test "should get new" do
    get new_wx_custom_url
    assert_response :success
  end

  test "should create wx_custom" do
    assert_difference('Custom.count') do
      post wx_customs_url, params: { wx_custom: {  } }
    end

    assert_redirected_to wx_custom_url(Custom.last)
  end

  test "should show wx_custom" do
    get wx_custom_url(@wx_custom)
    assert_response :success
  end

  test "should get edit" do
    get edit_wx_custom_url(@wx_custom)
    assert_response :success
  end

  test "should update wx_custom" do
    patch wx_custom_url(@wx_custom), params: { wx_custom: {  } }
    assert_redirected_to wx_custom_url(@wx_custom)
  end

  test "should destroy wx_custom" do
    assert_difference('Custom.count', -1) do
      delete wx_custom_url(@wx_custom)
    end

    assert_redirected_to wx_customs_url
  end
end
