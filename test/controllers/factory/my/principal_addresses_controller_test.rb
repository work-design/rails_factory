require 'test_helper'
class Factory::My::PrincipalAddressesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_my_principal_address = create factory_my_principal_addresses
  end

  test 'index ok' do
    get my_principal_addresses_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_principal_address_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('PrincipalAddress.count') do
      post my_principal_addresses_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_principal_address_url(@factory_my_principal_address)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_principal_address_url(@factory_my_principal_address)
    assert_response :success
  end

  test 'update ok' do
    patch my_principal_address_url(@factory_my_principal_address), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('PrincipalAddress.count', -1) do
      delete my_principal_address_url(@factory_my_principal_address)
    end

    assert_response :success
  end

end
