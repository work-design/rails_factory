require 'test_helper'
class Factory::Panel::BrandsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @brand = brands(:one)
  end

  test 'index ok' do
    get url_for(controller: 'factory/panel/brands')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'factory/panel/brands')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Brand.count') do
      post(
        url_for(controller: 'factory/panel/brands', action: 'create'),
        params: { brand: { name: @factory_panel_brand.name, organ_id: @factory_panel_brand.organ_id, parts_count: @factory_panel_brand.parts_count, products_count: @factory_panel_brand.products_count } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'factory/panel/brands', action: 'show', id: @brand.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'factory/panel/brands', action: 'edit', id: @brand.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'factory/panel/brands', action: 'update', id: @brand.id),
      params: { brand: { name: @factory_panel_brand.name, organ_id: @factory_panel_brand.organ_id, parts_count: @factory_panel_brand.parts_count, products_count: @factory_panel_brand.products_count } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Brand.count', -1) do
      delete url_for(controller: 'factory/panel/brands', action: 'destroy', id: @brand.id), as: :turbo_stream
    end

    assert_response :success
  end

end
