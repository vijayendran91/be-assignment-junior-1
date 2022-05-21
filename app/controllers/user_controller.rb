class UserController < ApplicationController
  require_relative "../platform/session_application"
  require_relative "../platform/bill_application"
  require_relative "../platform/expense_application"
  require_relative "../platform/session_application"

  include SessionApplication
  include BillApplication
  include ExpenseApplication
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
    @user = current_user
    @user_expenses = get_all_expenses_of_user_id(@user[:id])
    @user_borrowed = get_all_expenses_as_borrower_service(@user[:id])
    @user_borrowed_from = []
    (0..@user_borrowed.length-1).each do |i|
      @user_borrowed_from[i] =  get_user_by_id(@user_borrowed[i][:borrowed_from_id])
    end
  end

private
  def get_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
