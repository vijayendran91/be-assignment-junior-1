class UserController < ApplicationController
  require_relative "../platform/session_application"
  require_relative "../platform/bill_application"
  require_relative "../platform/expense_application"
  require_relative "../platform/session_application"

  include SessionApplication
  include BillApplication
  include ExpenseApplication
  include SessionApplication
  respond_to :html, :js
  def home
    @user = User.new
  end

  def sign_in
    #TODO Remove request.post?
    if request.post?
    elsif request.get?

    end
  end

  def expenses_with_user
    user = get_user_params_expense
    current_user = current_user()
    @all_expenses = get_all_expenses_bet_two_users(user, current_user[:id])
    render json: { expenses_table: render_to_string('partials/dashboard/_expenses_with_user_table', layout: false, locals: { all_expenses: @all_expenses, user: current_user}) }
  end

  def friends_expenses
    user = get_user_params_expense
    current_user = current_user()
    @all_expenses = get_all_expenses_of_user_id(user)
    render json: { expenses_table: render_to_string('partials/dashboard/_friends_expenses_table', layout: false, locals: { all_expenses: @all_expenses, user: user}) }
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
    @new_expense = Expense.new
    @all_users = get_all_users_except(@user[:id])
    @total_expense = ((@user[:total_owed].nil? ? 0:@user[:total_owed]) - (@user[:total_owe].nil? ? 0:@user[:total_owe]))
    @user_expenses = get_all_expenses_of_user_id(@user[:id])
    @user_borrowed = get_all_expenses_as_borrower_service(@user[:id])
  end

  def add_expense
    @new_expense = Expense.new
  end

private
  def get_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def get_user_params_expense
    params.require(:user_id)
  end

end
