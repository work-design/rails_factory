require 'test_helper'
class Factory::Panel::ProductTaxonTemplatesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @factory_panel_taxon_template = create factory_panel_taxon_templates
  end

  test 'index ok' do
    get panel_taxon_templates_url
    assert_response :success
  end

  test 'new ok' do
    get new_panel_taxon_template_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProductTaxonTemplate.count') do
      post panel_taxon_templates_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get panel_taxon_template_url(@factory_panel_taxon_template)
    assert_response :success
  end

  test 'edit ok' do
    get edit_panel_taxon_template_url(@factory_panel_taxon_template)
    assert_response :success
  end

  test 'update ok' do
    patch panel_taxon_template_url(@factory_panel_taxon_template), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProductTaxonTemplate.count', -1) do
      delete panel_taxon_template_url(@factory_panel_taxon_template)
    end

    assert_response :success
  end

end
