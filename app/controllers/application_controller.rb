# Base application controller.
# Defines global actions that take place for each page load
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Force login
  before_action :require_auth

  # Helper method for returning the currently authenticated user
  helper_method :authenticated?
  def authenticated?
    auth_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  # Method for requiring authentication
  def require_auth
    redirect_to login_path unless authenticated?
  end
end
