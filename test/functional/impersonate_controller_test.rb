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

  test 'configuration uses default model User' do
    user = mock('User')

    @controller.expects(:config_or_default).
      with(:authenticate_user_method, 'authenticate_user!').
      returns('authenticate_user!')
    @controller.expects(:config_or_default).
      with(:current_staff, 'current_user').
      returns('current_user')
    @controller.expects(:config_or_default).
      with(:user_is_staff_method, 'staff?').
      returns('staff?')

    @controller.expects(:authenticate_user!).once.returns(true)
    @controller.expects(:current_user).once.returns(user)
    @controller.expects(:authenticate_admin_user!).never
    @controller.expects(:current_admin_user).never

    get :index, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/'
    assert_equal user, assigns(:current_staff)
  end

  test 'configuration to use a different model than User' do
    admin_user = mock('AdminUser')

    @controller.expects(:config_or_default).
      with(:authenticate_user_method, 'authenticate_user!').
      returns('authenticate_admin_user!')
    @controller.expects(:config_or_default).
      with(:current_staff, 'current_user').
      returns('current_admin_user')
    @controller.expects(:config_or_default).
      with(:user_is_staff_method, 'staff?').
      returns('staff?')

    @controller.expects(:authenticate_user!).never
    @controller.expects(:current_user).never
    @controller.expects(:authenticate_admin_user!).once.returns(true)
    @controller.expects(:current_admin_user).once.returns(admin_user)

    get :index, :use_route => 'user_impersonate'
    assert_redirected_to 'http://test.host/'
    assert_equal admin_user, assigns(:current_staff)
  end
end

