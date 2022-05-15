class UserController < ApplicationController
  require_relative "../platform/session_application"
  include SessionApplication

  def home
    @user = User.new
  end

  def sign_in
    #TODO Remove request.post?
    if request.post?
    elsif request.get?

    end
  end

  def sign_up
    if request.post?
      begin
        create_new_user(get_user_params)
        redirect_to user_dashboard_path
      rescue InvalidCredentialsError => e
        flash.now[:notice] = e.message
        render user_sign_up_path
      end
    elsif request.get?
      @user = User.new
    end
  end

  def dashboard

  end

private
  def get_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
