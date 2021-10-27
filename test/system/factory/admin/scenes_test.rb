require "application_system_test_case"

class ScenesTest < ApplicationSystemTestCase
  setup do
    @factory_admin_scene = factory_admin_scenes(:one)
  end

  test "visiting the index" do
    visit factory_admin_scenes_url
    assert_selector "h1", text: "Scenes"
  end

  test "should create Scene" do
    visit factory_admin_scenes_url
    click_on "New Scene"

    fill_in "Book finish at", with: @factory_admin_scene.book_finish_at
    fill_in "Book finish days", with: @factory_admin_scene.book_finish_days
    fill_in "Book start at", with: @factory_admin_scene.book_start_at
    fill_in "Book start days", with: @factory_admin_scene.book_start_days
    fill_in "Deliver finish at", with: @factory_admin_scene.deliver_finish_at
    fill_in "Deliver start at", with: @factory_admin_scene.deliver_start_at
    fill_in "Title", with: @factory_admin_scene.title
    click_on "Create Scene"

    assert_text "Scene was successfully created"
    click_on "Back"
  end

  test "should update Scene" do
    visit factory_admin_scenes_url
    click_on "Edit", match: :first

    fill_in "Book finish at", with: @factory_admin_scene.book_finish_at
    fill_in "Book finish days", with: @factory_admin_scene.book_finish_days
    fill_in "Book start at", with: @factory_admin_scene.book_start_at
    fill_in "Book start days", with: @factory_admin_scene.book_start_days
    fill_in "Deliver finish at", with: @factory_admin_scene.deliver_finish_at
    fill_in "Deliver start at", with: @factory_admin_scene.deliver_start_at
    fill_in "Title", with: @factory_admin_scene.title
    click_on "Update Scene"

    assert_text "Scene was successfully updated"
    click_on "Back"
  end

  test "should destroy Scene" do
    visit factory_admin_scenes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Scene was successfully destroyed"
  end
end
