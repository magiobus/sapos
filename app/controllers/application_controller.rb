class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticated?
    @user = User.where(:email => session[:admin_user]).first
    @user && @user.email == session[:admin_user]
  end
  helper_method :authenticated?

  def auth_required
    redirect_to '/auth/admin' unless authenticated?
  end
end
