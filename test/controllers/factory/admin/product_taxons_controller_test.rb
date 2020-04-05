require 'test_helper'

class Factory::Admin::ProductTaxonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_taxon = create :product_taxon
  end

  test "should get index" do
    get product_taxons_url
    assert_response :success
  end

  test "should get new" do
    get new_product_taxon_url
    assert_response :success
  end

  test "should create product_taxon" do
    assert_difference('ProductTaxon.count') do
      post product_taxons_url, params: { product_taxon: { name: @product_taxon.name, position: @product_taxon.position, profit_margin: @product_taxon.profit_margin } }
    end

    assert_redirected_to product_taxon_url(ProductTaxon.last)
  end

  test "should show product_taxon" do
    get product_taxon_url(@product_taxon)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_taxon_url(@product_taxon)
    assert_response :success
  end

  test "should update product_taxon" do
    patch product_taxon_url(@product_taxon), params: { product_taxon: { name: @product_taxon.name, position: @product_taxon.position, profit_margin: @product_taxon.profit_margin } }
    assert_redirected_to product_taxon_url(@product_taxon)
  end

  test "should destroy product_taxon" do
    assert_difference('ProductTaxon.count', -1) do
      delete product_taxon_url(@product_taxon)
    end

    assert_redirected_to product_taxons_url
  end
end
