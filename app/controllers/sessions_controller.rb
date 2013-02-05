class SessionsController < ApplicationController
  skip_before_filter :require_login

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to user_path
  end

  def destroy
    session[:user_id] = nil
    render :text => "Successfully logged out"
  end

  def failure
    head 401
  end
end
