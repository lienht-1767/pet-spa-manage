class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t(".please_log_in")
    redirect_to login_url
  end

  def verify_admin!
    unless logged_in? && current_user.admin
      redirect_to(root_url)
    end
  end
end
