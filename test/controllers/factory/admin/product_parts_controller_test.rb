require 'test_helper'
class Factory::Admin::ProductPartsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_admin_product_part = create factory_admin_product_parts
  end

  test 'index ok' do
    get admin_product_parts_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_product_part_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProductPart.count') do
      post admin_product_parts_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_product_part_url(@factory_admin_product_part)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_product_part_url(@factory_admin_product_part)
    assert_response :success
  end

  test 'update ok' do
    patch admin_product_part_url(@factory_admin_product_part), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProductPart.count', -1) do
      delete admin_product_part_url(@factory_admin_product_part)
    end

    assert_response :success
  end

end
