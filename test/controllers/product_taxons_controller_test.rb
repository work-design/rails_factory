require 'test_helper'

class Factory::ProductTaxonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_taxon = create :product_taxon
  end

  test 'index ok' do
    get _product_taxons_url
    assert_response :success
  end

  test 'new ok' do
    get new__product_taxon_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProductTaxon.count') do
      post _product_taxons_url, params: { }
    end

    assert_redirected_to product_taxon_url(ProductTaxon.last)
  end

  test 'show ok' do
    get _product_taxon_url(@product_taxon)
    assert_response :success
  end

  test 'edit ok' do
    get edit__product_taxon_url(@product_taxon)
    assert_response :success
  end

  test 'update ok' do
    patch _product_taxon_url(@product_taxon), params: { }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProductTaxon.count', -1) do
      delete _product_taxon_url(@product_taxon)
    end

    assert_response :success
  end
end
