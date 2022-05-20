class SessionsController < ApplicationController
  require_relative "../platform/session_application"
  include SessionApplication

  def new
    @user = User.new
  end

  def create
    user_params = get_user_params(params)
    begin
      user_sign_in(user_params)
      redirect_to user_dashboard_path
    rescue => error
      flash.now[:danger] = error.message
      render user_sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to user_sign_in_path
  end

private
  def get_user_params(params)
    return params.require(:user).permit!
  end
end
