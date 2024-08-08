require 'test_helper'

class Factory::ProductTaxonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @taxon = create :taxon
  end

  test 'index ok' do
    get _taxons_url
    assert_response :success
  end

  test 'new ok' do
    get new__taxon_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProductTaxon.count') do
      post _taxons_url, params: { }
    end

    assert_redirected_to taxon_url(ProductTaxon.last)
  end

  test 'show ok' do
    get _taxon_url(@taxon)
    assert_response :success
  end

  test 'edit ok' do
    get edit__taxon_url(@taxon)
    assert_response :success
  end

  test 'update ok' do
    patch _taxon_url(@taxon), params: { }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProductTaxon.count', -1) do
      delete _taxon_url(@taxon)
    end

    assert_response :success
  end
end
