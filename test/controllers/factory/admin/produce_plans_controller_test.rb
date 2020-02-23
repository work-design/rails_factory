require 'test_helper'
class Factory::Admin::ProducePlansControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_admin_produce_plan = create factory_admin_produce_plans
  end

  test 'index ok' do
    get admin_produce_plans_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_produce_plan_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProducePlan.count') do
      post admin_produce_plans_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_produce_plan_url(@factory_admin_produce_plan)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_produce_plan_url(@factory_admin_produce_plan)
    assert_response :success
  end

  test 'update ok' do
    patch admin_produce_plan_url(@factory_admin_produce_plan), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProducePlan.count', -1) do
      delete admin_produce_plan_url(@factory_admin_produce_plan)
    end

    assert_response :success
  end

end
