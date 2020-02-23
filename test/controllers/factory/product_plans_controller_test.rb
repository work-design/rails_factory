require 'test_helper'
class Factory::ProductPlansControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_product_plan = create factory_product_plans
  end

  test 'index ok' do
    get factory_product_plans_url
    assert_response :success
  end

  test 'new ok' do
    get new_factory_product_plan_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProductPlan.count') do
      post factory_product_plans_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get factory_product_plan_url(@factory_product_plan)
    assert_response :success
  end

  test 'edit ok' do
    get edit_factory_product_plan_url(@factory_product_plan)
    assert_response :success
  end

  test 'update ok' do
    patch factory_product_plan_url(@factory_product_plan), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProductPlan.count', -1) do
      delete factory_product_plan_url(@factory_product_plan)
    end

    assert_response :success
  end

end
