module UserImpersonate
  class Engine < Rails::Engine
    config.user_class           = "User"
    config.user_finder          = "find"   # User.find
    config.user_id_column       = "id"     # Such that User.find(aUser.id) works
    config.user_name_column     = "name"   # Such that User.where("#{user_name_column} like ?", "%#{params[:search]}%") works
    config.user_is_staff_method = "staff?" # current_user.staff?

    config.redirect_on_impersonate = "/"
    config.redirect_on_revert = "/impersonate"

    config.authenticate_user_method = "authenticate_user!" # protect impersonation controller
                                                           # change to 'authenticate_admin_user!' if model AdminUser
    config.sign_in_user_method      = "sign_in"            # sign_in(user)

    config.staff_class   = "User"   # if you have AdminUser instead
    config.staff_finder  = "find"   # AdminUser.find
    config.current_staff = "current_user" # if AdminUser model try "current_admin_user"
  end
end
