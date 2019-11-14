require 'test_helper'

class LearningEntriesControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  test "should get index" do
    get learning_entries_path
    assert_redirected_to "/login"
  end

  test "should enter admin to learning" do
    log_in_as(@user, remember_me: '1')
    get learning_entries_path
    assert_response :success
  end

  test "shouldn't enter others to learning" do
    log_in_as(@other_user, remember_me: '1')
    get learning_entries_path
    assert_redirected_to root_path
  end

end
