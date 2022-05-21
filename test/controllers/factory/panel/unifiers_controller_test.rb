require 'test_helper'
class Factory::Panel::UnifiersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @unifier = unifiers(:one)
  end

  test 'index ok' do
    get url_for(controller: 'factory/panel/unifiers')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'factory/panel/unifiers')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Unifier.count') do
      post(
        url_for(controller: 'factory/panel/unifiers', action: 'create'),
        params: { unifier: { code: @factory_panel_unifier.code, name: @factory_panel_unifier.name } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'factory/panel/unifiers', action: 'show', id: @unifier.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'factory/panel/unifiers', action: 'edit', id: @unifier.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'factory/panel/unifiers', action: 'update', id: @unifier.id),
      params: { unifier: { code: @factory_panel_unifier.code, name: @factory_panel_unifier.name } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Unifier.count', -1) do
      delete url_for(controller: 'factory/panel/unifiers', action: 'destroy', id: @unifier.id), as: :turbo_stream
    end

    assert_response :success
  end

end
