require 'test_helper'
class Factory::Panel::ProvidersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_panel_provider = create factory_panel_providers
  end

  test 'index ok' do
    get panel_providers_url
    assert_response :success
  end

  test 'new ok' do
    get new_panel_provider_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Provider.count') do
      post panel_providers_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get panel_provider_url(@factory_panel_provider)
    assert_response :success
  end

  test 'edit ok' do
    get edit_panel_provider_url(@factory_panel_provider)
    assert_response :success
  end

  test 'update ok' do
    patch panel_provider_url(@factory_panel_provider), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Provider.count', -1) do
      delete panel_provider_url(@factory_panel_provider)
    end

    assert_response :success
  end

end
