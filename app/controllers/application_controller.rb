class ApplicationController < ActionController::Base
  # before_action :authenticate_user! TODO
  def current_user
    if session[:user_id]
      User.find(:id => session[:user_id])
    end
  end
end
