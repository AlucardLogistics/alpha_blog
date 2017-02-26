require 'test_helper'

class UserSignUpTest < ActionDispatch::IntegrationTest
  
  test "user_sign_up_test" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "jiji", email: "jiji@gmail.com", password: "password"}
    end
    assert_template 'users/show'
  end
  
end