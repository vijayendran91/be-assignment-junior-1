module ExpenseApplication
  require_relative '../services/user_services'
  require_relative '../services/expense_services'
  require_relative '../helpers/expense_helper'

  include UserServices
  include ExpenseHelper
  include ExpenseServices

  def add_expenses(bill, participants)
    no_of_parts = bill[:no_parts]
    expense = {
      :amount => get_participant_amount(bill[:amount], no_of_parts),
      :borrowed_from => bill.paid_by,
      :bill => bill
    }
    expenses = []
    participants.each do |user_id|
      expense[:borrower] = get_user_by_id_service(user_id)
      @expense = add_expense_with_params_service(expense)
      unless @expense.errors.empty?
        raise ExpenseStorageError.new(@expense.errors.full_messages.to_sentence)
      end
      expenses.push(@expense)
    end
    expenses
  end

  def settle_an_expense()

  end

  def get_total_expense_of_user_id(user_id)
    expenses = get_all_expenses_of_user_service(user_id)
    total_expense = 0.0
    expenses.each do |expense|
      if(expense.borrowed_from_id == user_id)
        total_expense += expense.amount
      elsif(expense.borrower_id == user_id)
        total_expense -= expense.amount
      end
    end
    total_expense
  end

  def get_all_expenses_of_user_id(user_id)
    get_all_expenses_of_user_service(user_id)
  end

  def get_all_expenses_borrowed_from(user_id)
    get_all_expenses_borrowed_from_service(user_id)
  end

  def get_all_expenses_as_borrower(user_id)
    get_all_expenses_as_borrower(user_id)
  end

  #gets expenses between two users
  def get_all_expenses_bet_two_users(user_id1, user_id2)
    get_all_expenses_bet_two_users_service(user_id1, user_id2)
  end

  #Gets Unsettled expenses between the two users
  def get_expenses_between_two_users(borrowed_from_id, borrower_id)
    get_expenses_between_two_users_service(borrowed_from_id, borrower_id)
  end

  def settle_an_expense_with_id(expense_id)
    settle_an_expense_with_id_service(expense_id)
  end

end
