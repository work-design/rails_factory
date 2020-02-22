require 'test_helper'
class Factory::Admin::AddressesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_admin_address = create factory_admin_addresses
  end

  test 'index ok' do
    get admin_addresses_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_address_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Address.count') do
      post admin_addresses_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_address_url(@factory_admin_address)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_address_url(@factory_admin_address)
    assert_response :success
  end

  test 'update ok' do
    patch admin_address_url(@factory_admin_address), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Address.count', -1) do
      delete admin_address_url(@factory_admin_address)
    end

    assert_response :success
  end

end
