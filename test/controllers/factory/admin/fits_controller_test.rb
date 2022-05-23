require 'test_helper'
class Factory::Admin::FitsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @fit = fits(:one)
  end

  test 'index ok' do
    get url_for(controller: 'factory/admin/fits')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'factory/admin/fits')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Fit.count') do
      post(
        url_for(controller: 'factory/admin/fits', action: 'create'),
        params: { fit: { part_brand_id: @factory_admin_fit.part_brand_id, part_product_id: @factory_admin_fit.part_product_id, part_production_id: @factory_admin_fit.part_production_id, part_serial_id: @factory_admin_fit.part_serial_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'factory/admin/fits', action: 'show', id: @fit.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'factory/admin/fits', action: 'edit', id: @fit.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'factory/admin/fits', action: 'update', id: @fit.id),
      params: { fit: { part_brand_id: @factory_admin_fit.part_brand_id, part_product_id: @factory_admin_fit.part_product_id, part_production_id: @factory_admin_fit.part_production_id, part_serial_id: @factory_admin_fit.part_serial_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Fit.count', -1) do
      delete url_for(controller: 'factory/admin/fits', action: 'destroy', id: @fit.id), as: :turbo_stream
    end

    assert_response :success
  end

end
