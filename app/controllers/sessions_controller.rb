class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = get_user_params(params)
    @user = User.find_by(:email => user_params[:email])
    if @user && @user.is_password?(user_params[:password])
      session[:user_id] = @user[:id]
      redirect_to user_dashboard_path
    else
      flash.now[:danger] = "Incorrect Credentials. Please try again."
      render user_sign_in_path
    end
  end

private
  def get_user_params(params)
    return params.require(:user).permit!
  end
end
