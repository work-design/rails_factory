require 'test_helper'
class Factory::Panel::SerialsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @serial = serials(:one)
  end

  test 'index ok' do
    get url_for(controller: 'factory/panel/serials')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'factory/panel/serials')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Serial.count') do
      post(
        url_for(controller: 'factory/panel/serials', action: 'create'),
        params: { serial: { name: @factory_panel_serial.name } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'factory/panel/serials', action: 'show', id: @serial.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'factory/panel/serials', action: 'edit', id: @serial.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'factory/panel/serials', action: 'update', id: @serial.id),
      params: { serial: { name: @factory_panel_serial.name } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Serial.count', -1) do
      delete url_for(controller: 'factory/panel/serials', action: 'destroy', id: @serial.id), as: :turbo_stream
    end

    assert_response :success
  end

end
