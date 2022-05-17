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
    Expense.where(:borrowed_from => user_id).or(Expense.where(:borrower => user_id))
  end

  def get_all_expenses_borrowed_from_service(user_id)
    Expense.where(:borrowed_from => user_id)
  end

  def get_all_expenses_as_borrower_service(user_id)
    Expense.where(:borrower => user_id)
  end

  def get_all_expenses_from_user_service(user_id1, user_id2)
    Expense.where(:borrowed_from => user_id1).(Expense.where(:borrower => user_id2))
  end
end
