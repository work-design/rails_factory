require 'test_helper'
class Factory::Admin::ProvidesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @provide = provides(:one)
  end

  test 'index ok' do
    get url_for(controller: 'factory/admin/provides')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'factory/admin/provides')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Provide.count') do
      post(
        url_for(controller: 'factory/admin/provides', action: 'create'),
        params: { provide: { provider_id: @factory_admin_provide.provider_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'factory/admin/provides', action: 'show', id: @provide.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'factory/admin/provides', action: 'edit', id: @provide.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'factory/admin/provides', action: 'update', id: @provide.id),
      params: { provide: { provider_id: @factory_admin_provide.provider_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Provide.count', -1) do
      delete url_for(controller: 'factory/admin/provides', action: 'destroy', id: @provide.id), as: :turbo_stream
    end

    assert_response :success
  end

end
