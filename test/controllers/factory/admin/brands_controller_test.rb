require 'test_helper'
class Factory::Admin::BrandsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @brand = brands(:one)
  end

  test 'index ok' do
    get url_for(controller: 'factory/admin/brands')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'factory/admin/brands')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Brand.count') do
      post(
        url_for(controller: 'factory/admin/brands', action: 'create'),
        params: { brand: { logo: @factory_admin_brand.logo, name: @factory_admin_brand.name } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'factory/admin/brands', action: 'show', id: @brand.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'factory/admin/brands', action: 'edit', id: @brand.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'factory/admin/brands', action: 'update', id: @brand.id),
      params: { brand: { logo: @factory_admin_brand.logo, name: @factory_admin_brand.name } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Brand.count', -1) do
      delete url_for(controller: 'factory/admin/brands', action: 'destroy', id: @brand.id), as: :turbo_stream
    end

    assert_response :success
  end

end
