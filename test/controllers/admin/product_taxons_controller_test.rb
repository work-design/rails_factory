require 'test_helper'

class Admin::ProductTaxonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_product_taxon = admin_product_taxons(:one)
  end

  test "should get index" do
    get admin_product_taxons_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_product_taxon_url
    assert_response :success
  end

  test "should create admin_product_taxon" do
    assert_difference('ProductTaxon.count') do
      post admin_product_taxons_url, params: { admin_product_taxon: { name: @admin_product_taxon.name, position: @admin_product_taxon.position, profit_margin: @admin_product_taxon.profit_margin } }
    end

    assert_redirected_to admin_product_taxon_url(ProductTaxon.last)
  end

  test "should show admin_product_taxon" do
    get admin_product_taxon_url(@admin_product_taxon)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_product_taxon_url(@admin_product_taxon)
    assert_response :success
  end

  test "should update admin_product_taxon" do
    patch admin_product_taxon_url(@admin_product_taxon), params: { admin_product_taxon: { name: @admin_product_taxon.name, position: @admin_product_taxon.position, profit_margin: @admin_product_taxon.profit_margin } }
    assert_redirected_to admin_product_taxon_url(@admin_product_taxon)
  end

  test "should destroy admin_product_taxon" do
    assert_difference('ProductTaxon.count', -1) do
      delete admin_product_taxon_url(@admin_product_taxon)
    end

    assert_redirected_to admin_product_taxons_url
  end
end
