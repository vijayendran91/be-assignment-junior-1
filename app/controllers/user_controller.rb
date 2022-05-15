class UserController < ApplicationController
  def home
    @user = User.new
  end

  def sign_in
    if request.post?
        binding.pry
    elsif request.get?

    end
  end

  def sign_up
    if request.post?
      @user = User.new(get_user_params)
      if @user.save
        redirect_to user_dashboard_path, notice: "Please check your email for confirmation instructions."
      else
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
    return params.require(:user).permit!
  end

end
