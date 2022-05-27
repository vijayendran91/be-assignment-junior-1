module ExpenseHelper

  def get_participant_amount(amount, no_of_parts)
    amount/no_of_parts
  end

  def get_unequal_share_amount(total_amount, percentage)
    (total_amount * percentage)/100
  end

end
