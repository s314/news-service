require 'test_helper'

class ReadLaterEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get read_later_entries_new_url
    assert_response :success
  end

  test "should get index" do
    get read_later_entries_index_url
    assert_response :success
  end

  test "should get destroy" do
    get read_later_entries_destroy_url
    assert_response :success
  end

end
