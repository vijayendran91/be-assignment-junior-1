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
      redirect_to user_dashboard_path if logged_in?
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
    if request.post?
      begin
        validate_add_expense_params(params)
        no_of_parts =  params[:participants].size
        bill_params = {
          :paid_by => current_user,
          :amount =>  params[:bill_amount],
          :no_parts => params[:participants].size+1,
          :desc => params[:desc]
        }
        bill = add_bill(bill_params)
        if(!params[:unequal].nil? && params[:unequal] == "true")
          share_perc = params[:shares]
          shares = []
          share_perc.each do |share|
            shares.push(share.to_f)
          end
          add_expenses(bill, params[:participants], true, shares)
        else
          add_expenses(bill, params[:participants], false, [])
        end
        redirect_to user_dashboard_path
      rescue => error
        @user = current_user
        @new_expense = Expense.new
        @all_users = get_all_users_except(@user[:id])
        @total_expense = ((@user[:total_owed].nil? ? 0:@user[:total_owed]) - (@user[:total_owe].nil? ? 0:@user[:total_owe]))
        @user_expenses = get_all_expenses_of_user_id(@user[:id])
        @user_borrowed = get_all_expenses_as_borrower_service(@user[:id])
        @errors = error.message
        render user_dashboard_path
      end
    elsif request.get?
      @current_user = current_user
      @all_users = get_all_users_except(@current_user[:id])
      @new_expense = Expense.new
    end
  end


  def settle_expense
    if request.get?
      get_settle_expense_params
      @expense = get_expense_by_id(params[:expense_id])
      render :json => {:success => true, :expense => @expense}
    elsif request.post?
      get_settle_expense_params
      settle_an_expense_with_id(params[:expense_id], params[:note])
      redirect_to user_dashboard_path
    end
  end

private
  def get_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def get_user_params_expense
    params.require(:user_id)
  end

  def get_add_expense_params
    params.permit(:unequal)
    params.permit(:bill_amount)
    params.permit(:shares)
    params.permit(:participants)
    params.permit(:desc)
  end

  def get_settle_expense_params
    params.permit(:expense_id)
    params.permit(:note)
  end
end
