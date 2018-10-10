require 'test_helper'

class ActiveStorageExt::Admin::AttachmentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create :user
    @user.avatar.attach io: file_fixture('empty_file.txt').open, filename: 'xx.txt'

    @active_storage_attachment = @user.avatar.attachment
  end

  test 'destroy ok' do
    assert_difference('ActiveStorage::Attachment.count', -1) do
      delete rails_attachment_url(@active_storage_attachment), xhr: true
    end
  end
end
