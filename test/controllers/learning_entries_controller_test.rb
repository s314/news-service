require 'test_helper'

class LearningEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get learning_entries_create_url
    assert_response :success
  end

  test "should get index" do
    get learning_entries_index_url
    assert_response :success
  end

  test "should get destroy" do
    get learning_entries_destroy_url
    assert_response :success
  end

end
