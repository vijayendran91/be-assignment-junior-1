module ExpenseHelper

  def get_participant_amount(amount, no_of_parts)
    (amount/no_of_parts).round(2)
  end

  def get_unequal_share_amount(total_amount, percentage)
    ((total_amount * percentage)/100).round(2)
  end

  def validate_add_expense_params(params)
    if( params[:participants].nil? || params[:participants].size <=0 )
      raise ExpenseZeroParticipants.new("Please select atleast one user to create an expense")
    elsif(params[:amount].nil? || params[:amount] <= 0)
      raise ExpenseInvalidData.new("Please enter a valid amount to create an expense")
    end
  end

end
