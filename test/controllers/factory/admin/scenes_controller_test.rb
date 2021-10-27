require 'test_helper'
class Factory::Admin::ScenesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @scene = scenes(:one)
  end

  test 'index ok' do
    get url_for(controller: 'factory/admin/scenes')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'factory/admin/scenes')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Scene.count') do
      post(
        url_for(controller: 'factory/admin/scenes', action: 'create'),
        params: { scene: { book_finish_at: @factory_admin_scene.book_finish_at, book_finish_days: @factory_admin_scene.book_finish_days, book_start_at: @factory_admin_scene.book_start_at, book_start_days: @factory_admin_scene.book_start_days, deliver_finish_at: @factory_admin_scene.deliver_finish_at, deliver_start_at: @factory_admin_scene.deliver_start_at, title: @factory_admin_scene.title } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'factory/admin/scenes', action: 'show', id: @scene.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'factory/admin/scenes', action: 'edit', id: @scene.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'factory/admin/scenes', action: 'update', id: @scene.id),
      params: { scene: { book_finish_at: @factory_admin_scene.book_finish_at, book_finish_days: @factory_admin_scene.book_finish_days, book_start_at: @factory_admin_scene.book_start_at, book_start_days: @factory_admin_scene.book_start_days, deliver_finish_at: @factory_admin_scene.deliver_finish_at, deliver_start_at: @factory_admin_scene.deliver_start_at, title: @factory_admin_scene.title } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Scene.count', -1) do
      delete url_for(controller: 'factory/admin/scenes', action: 'destroy', id: @scene.id), as: :turbo_stream
    end

    assert_response :success
  end

end
