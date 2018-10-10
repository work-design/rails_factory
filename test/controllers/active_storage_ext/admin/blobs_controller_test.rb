require 'test_helper'
class ActiveStorageExt::Admin::BlobsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @blob = blobs(:one)
  end

  test "should get index" do
    get 'rails/blobs'
    assert_response :success
  end

  test "should get new" do
    get new_blob_url
    assert_response :success
  end

  test "should create blob" do
    assert_difference('Blob.count') do
      post blobs_url, params: { blob: {  } }
    end

    assert_redirected_to blob_url(Blob.last)
  end

  test "should destroy blob" do
    assert_difference('Blob.count', -1) do
      delete blob_url(@blob)
    end

    assert_redirected_to blobs_url
  end
end
