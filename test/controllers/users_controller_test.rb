require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  test "should get sign up page" do
    get signup_path
    assert_response :success
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path(user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" })
    end
    assert_template 'users/new'
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
