require 'test_helper'

class ActiveStorageExt::VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @user.avatar.attach io: file_fixture('empty_file.txt').open, filename: 'xx.txt'

    @active_storage_video = @user.avatar.attachment
  end

  test 'show ok' do
    get rails_video_url(@active_storage_video)
    assert_response :success
  end

end
