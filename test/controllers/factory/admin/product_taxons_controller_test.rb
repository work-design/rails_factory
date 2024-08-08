require 'test_helper'

class Factory::Admin::ProductTaxonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @taxon = create :taxon
  end

  test "should get index" do
    get taxons_url
    assert_response :success
  end

  test "should get new" do
    get new_taxon_url
    assert_response :success
  end

  test "should create taxon" do
    assert_difference('ProductTaxon.count') do
      post taxons_url, params: { taxon: { name: @taxon.name, position: @taxon.position, profit_margin: @taxon.profit_margin } }
    end

    assert_redirected_to taxon_url(ProductTaxon.last)
  end

  test "should show taxon" do
    get taxon_url(@taxon)
    assert_response :success
  end

  test "should get edit" do
    get edit_taxon_url(@taxon)
    assert_response :success
  end

  test "should update taxon" do
    patch taxon_url(@taxon), params: { taxon: { name: @taxon.name, position: @taxon.position, profit_margin: @taxon.profit_margin } }
    assert_redirected_to taxon_url(@taxon)
  end

  test "should destroy taxon" do
    assert_difference('ProductTaxon.count', -1) do
      delete taxon_url(@taxon)
    end

    assert_redirected_to taxons_url
  end
end
