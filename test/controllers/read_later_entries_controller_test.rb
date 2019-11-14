require 'test_helper'

class ReadLaterEntriesControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  test "read later should redirected to login" do
    get read_later_entries_path
    assert_redirected_to "/login"
  end

  test "should enter to read later" do
    log_in_as(@user, remember_me: '1')
    get read_later_entries_path
    assert_response :success
  end

end
