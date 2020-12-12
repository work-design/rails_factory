require 'test_helper'
class Factory::Admin::FactoryTaxonsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_admin_factory_taxon = create factory_admin_factory_taxons
  end

  test 'index ok' do
    get admin_factory_taxons_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_factory_taxon_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('FactoryTaxon.count') do
      post admin_factory_taxons_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_factory_taxon_url(@factory_admin_factory_taxon)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_factory_taxon_url(@factory_admin_factory_taxon)
    assert_response :success
  end

  test 'update ok' do
    patch admin_factory_taxon_url(@factory_admin_factory_taxon), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('FactoryTaxon.count', -1) do
      delete admin_factory_taxon_url(@factory_admin_factory_taxon)
    end

    assert_response :success
  end

end
