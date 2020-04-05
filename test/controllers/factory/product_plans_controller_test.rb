require 'test_helper'
class Factory::ProductPlansControllerTest < ActionDispatch::IntegrationTest

  setup do
    @product_plan = create :product_plan
  end

  test 'index ok' do
    get product_plans_url
    assert_response :success
  end

  test 'new ok' do
    get new_product_plan_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProductPlan.count') do
      post product_plans_url, params: { }
    end

    assert_response :success
  end

  test 'show ok' do
    get product_plan_url(@product_plan)
    assert_response :success
  end

  test 'edit ok' do
    get edit_product_plan_url(@product_plan)
    assert_response :success
  end

  test 'update ok' do
    patch product_plan_url(@product_plan), params: { }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProductPlan.count', -1) do
      delete product_plan_url(@product_plan)
    end

    assert_response :success
  end

end
