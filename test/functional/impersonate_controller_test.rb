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
end

