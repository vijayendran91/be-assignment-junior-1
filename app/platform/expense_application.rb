module ExpenseApplication
  require_relative '../services/user_services'
  require_relative '../services/expense_services'
  require_relative '../helpers/expense_helper'

  include UserServices
  include ExpenseHelper
  include ExpenseServices

  def add_expenses(bill, participants, unequal, share_perc)
    no_of_parts = bill[:no_parts]
    expense = {
      :borrowed_from => bill.paid_by,
      :bill => bill,
      :bill_desc => bill.desc
    }
    expenses = []
    if(unequal == false)
      expense[:amount] = get_participant_amount(bill[:amount], no_of_parts)
      update_user_total_owed(bill.paid_by, expense[:amount], no_of_parts)
      participants.each do |user_id|
        borrower = get_user_by_id_service(user_id)
        expense[:borrower] = borrower
        expense[:borrower_name] = borrower[:first_name]
        expense[:borrowed_from_name] = bill.paid_by.first_name
        update_user_total_owe(borrower, expense[:amount])
        @expense = add_expense_with_params_service(expense)
        expenses.push(@expense)
      end
    elsif(unequal == true)
      (0..participants.length-1).each do |i|
        expense[:amount] = get_unequal_share_amount(bill[:amount], share_perc[i])
        borrower = get_user_by_id_service(participants[i])
        expense[:borrower] = borrower
        expense[:borrower_name] = borrower[:first_name]
        expense[:borrowed_from_name] = bill.paid_by.first_name
        update_user_total_owe(borrower, expense[:amount])
        @expense = add_expense_with_params_service(expense)
        expenses.push(@expense)
      end
      update_user_total_owed_unequal(expense[:borrowed_from], share_perc, bill[:amount])
    end
    unless @expense.errors.empty?
      raise ExpenseStorageError.new(@expense.errors.full_messages.to_sentence)
    end
    expenses
  end

  def update_user_total_owed(user, amount, no_of_parts)
    total_owed = amount * (no_of_parts - 1)
    addition = 0
    unless(user.total_owed == nil)
      addition = user.total_owed
    end
    total_owed += addition
    update_user_total_owed_service(user, total_owed)
  end

  def update_user_total_owed_unequal(user,share_perc, bill_amount)
    addition = 0
    total_perc = 0
    share_perc.each do |perc|
      total_perc += perc
    end
    payer_perc = 100 - total_perc
    amount = get_unequal_share_amount(bill_amount, total_perc)
    addition = user.total_owed unless(user.total_owed == nil)
    addition+=amount
    update_user_total_owed_service(user, addition)
  end

  def update_user_total_owe(user, amount)
    total_owe = amount
    addition = 0
    unless(user.total_owe == nil)
      addition = user.total_owe
    end
    total_owe += addition
    update_user_total_owe_service(user, total_owe)
  end

  def settle_user_total_owe(user,amount)
    update_user_total_owe_service(user, amount)
  end

  def settle_user_total_owed(user,amount)
    update_user_total_owed_service(user, amount)
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
  def get_expense_by_id(expense_id)
    get_expense_with_id_service(expense_id)
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

  def settle_an_expense_with_id(expense_id, note)
    expense = get_expense_by_id(expense_id)
    borrower = get_user_by_id(expense.borrower_id)
    borrowed_from = get_user_by_id(expense.borrowed_from_id)
    settle_user_total_owe(borrower, (borrower.total_owe - expense[:amount]))
    settle_user_total_owed(borrowed_from, (borrowed_from.total_owed - expense[:amount]))
    settle_an_expense_with_id_service(expense_id, note)
  end

  def get_all_expenses_log(user_id)
    get_all_expenses_log_service(user_id)
  end

end
