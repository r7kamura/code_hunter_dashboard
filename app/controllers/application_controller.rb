class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to login_path unless logged_in?
  end

  def require_latest_report
    @report = Report.latest
  end

  def login_path
    "/auth/github"
  end
end
