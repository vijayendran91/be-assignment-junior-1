module SessionApplication
  require_relative '../services/user_services'
  require_relative '../helpers/user_helper'

  include UserServices
  include UserHelper

  def user_sign_in(params)
    @user = get_user_by_email_service(params[:email])
    if @user && @user.is_password?(params[:password])
      session[:user_id] = @user[:id]
    else
      raise InvalidCredentialsError.new("Incorrect Credentials. Please try again.")
    end
    @user
  end

  def create_new_user(params)
    validate_sign_up_params(params)
    validate_email(params[:email])
    @user = create_new_user_service(params)
    unless @user.errors.empty?
      raise InvalidCredentialsError.new(@user.errors.full_messages.to_sentence)
    end
    @user
  end

  def get_current_user_from_session
    session[:user_id]
  end

  def get_user_by_email(email)
    get_user_by_email_service(email)
  end
  def get_user_by_id(user_id)
    get_user_by_id_service(user_id)
  end

  def get_all_users
    get_all_users_service
  end

  def get_all_users_except(user_id)
    get_all_users_except_service(user_id)
  end
end
