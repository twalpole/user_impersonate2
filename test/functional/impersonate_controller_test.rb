require 'test_helper'

class UserImpersonate::ImpersonateControllerTest < ActionController::TestCase
  test 'index should require authentication' do
    get :index, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/users/sign_in'
  end

  test 'create should require authentication' do
    get :create, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/users/sign_in'
  end

  test 'destroy should not require authentication' do
    delete :destroy, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/'
  end

  test 'configuration to use a different model than User' do
    # AdminUser instead of User
    UserImpersonate::Engine.config[:current_staff]            = "current_admin_user"
    UserImpersonate::Engine.config[:authenticate_user_method] = "authenticate_admin_user!"

    # must get the correct configuration instead of returning the default
    @controller.expects(:config_or_default).
      with(:authenticate_user_method, 'authenticate_user!').
      returns("authenticate_admin_user!")
    @controller.expects(:config_or_default).
      with(:current_staff, "current_user").
      returns("current_admin_user")
    @controller.expects(:config_or_default).
      with(:user_is_staff_method, "staff?").
      returns("staff?")
    @controller.stubs(:authenticate_admin_user!).returns(true)
    @controller.stubs(:current_admin_user).returns(mock('User'))
    get :index, :use_route => "user_impersonate"
  end
end

