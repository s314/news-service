require 'test_helper'

class SourcesControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  test "should get index" do
    log_in_as(@user, remember_me: '1')
    get sources_path
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user, remember_me: '1')
    get new_source_path
    assert_response :success
  end

  test "redirect user from source" do
    log_in_as(@other_user, remember_me: 1)
    get sources_path
    assert_redirected_to root_path
  end

end
