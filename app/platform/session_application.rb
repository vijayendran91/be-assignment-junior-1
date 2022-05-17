module SessionApplication
  require_relative '../services/user_services'
  require_relative '../helpers/user_helper'

  include UserServices
  include UserHelper

  def user_sign_in(params)
    @user = get_user_by_email_service(params[:email])
    if @user && @user.is_password?(params[:password])
      # add_user_session TODO
    else
      #TODO Exception Incorrect Credentials
      raise InvalidCredentialsError.new("Incorrect Credentials. Please try again.")
    end
  end

  def create_new_user(params)
    #Evaluvate email and password
    validate_email(params[:email])
    @user = create_new_user_service(params)
    unless @user.errors.empty?
      raise InvalidCredentialsError.new(@user.errors.full_messages.to_sentence)
    end
  end
end
