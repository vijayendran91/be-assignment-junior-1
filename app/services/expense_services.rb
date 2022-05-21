module ExpenseServices

  def add_expense_with_params_service(params)
    expense_params = {
      :bill => params[:bill],
      :borrower => params[:borrower],
      :borrowed_from => params[:borrowed_from],
      :amount => params[:amount],
      :settled => false,
      :notes => params[:notes]
    }
    expense = Expense.new(expense_params)

    expense.save
    expense
  end

  def get_expense_with_id_service(exp_id)
    Expense.find_by(:id => exp_id)
  end

  def get_all_expenses_of_user_service(user_id)
    Expense.where(:settled => false).and(Expense.where(:borrowed_from => user_id).or(Expense.where(:borrower => user_id)))
  end

  def get_all_expenses_borrowed_from_service(user_id)
    Expense.where(:settled => false).and(Expense.where(:borrowed_from => user_id))
  end

  def get_all_expenses_as_borrower_service(user_id)
    Expense.where(:settled => false).and(Expense.where(:borrower => user_id))
  end

  def get_all_expenses_bet_two_users_service(user_id1, user_id2)
    Expense.where(:borrowed_from => user_id1).and(Expense.where(:borrower => user_id2)).or(
      Expense.where(:borrowed_from => user_id2).and(Expense.where(:borrower => user_id1)))
  end

  def get_expenses_between_two_users_service(borrowed_from_id, borrower_id)
    Expense.where(:settled => false).and(Expense.where(:borrowed_from => borrowed_from_id).and(Expense.where(:borrower => borrower_id)))
  end

  def settle_an_expense_with_id_service(expense_id)
    expense = Expense.find_by(:id => expense_id)
    expense.update(:settled => true)
    expense
  end
end
