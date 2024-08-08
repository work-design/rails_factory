require 'test_helper'
class Factory::Admin::ProductPartTaxonsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_admin_taxon_component = create factory_admin_taxon_components
  end

  test 'index ok' do
    get admin_taxon_components_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_taxon_component_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProductPartTaxon.count') do
      post admin_taxon_components_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_taxon_component_url(@factory_admin_taxon_component)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_taxon_component_url(@factory_admin_taxon_component)
    assert_response :success
  end

  test 'update ok' do
    patch admin_taxon_component_url(@factory_admin_taxon_component), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProductPartTaxon.count', -1) do
      delete admin_taxon_component_url(@factory_admin_taxon_component)
    end

    assert_response :success
  end

end
