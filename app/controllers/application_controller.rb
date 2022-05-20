class ApplicationController < ActionController::Base
  before_action :authorized, :except => [:sign_in, :sign_up, :create]
  helper_method :logged_in?, :current_user

  def current_user
    if session[:user_id]
      User.find_by(:id => session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to user_sign_in_path unless logged_in?
  end
end
