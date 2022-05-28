

Given("Following {string} the expense between user {string} and {string}") do |string1, string2, string3,table|
  table = table.raw
  contents = table.first
  (1..table.size-1).each do |i|
    borrowed_from = get_user_by_email(table[i][0])
    borrower = get_user_by_email(table[i][1])
    amount = table[i][2]
    expenses = get_expenses_between_two_users(borrowed_from[:id], borrower[:id]).first
    if(string1 == "is")
      amount.to_f.should == expenses.amount
    end
  end
end

And("User {string} settles the following expense") do |borrower, table|
  table = table.raw
  borrowed_from = get_user_by_email(table[1][0])
  borrower = get_user_by_email(borrower)
  amount = table[1][1]
  expense = get_expenses_between_two_users(borrowed_from, borrower).first
  settle_an_expense_with_id(expense[:id], "Test Settle")
end

Then("User {string} has the following expenses") do |string, table|
  user = get_user_by_email(string)
  table = table.raw
  expenses = get_all_expenses_of_user_id(user[:id])
  (0..expenses.length-1).each do |i|
    if(expenses[i].borrower.id == user.id)
      unless(expenses[i].borrower.email == table[i+1][0] && expenses[i].borrowed_from.email == table[i+1][1] && expenses[i].amount == table[i+1][2].to_f)
        fail("Expense mismatch #{expenses[i].borrower.email} == #{table[i+1][1]} && #{expenses[i].borrowed_from.email} == #{table[i+1][0]} && #{expenses[i].amount} == #{table[i+1][2].to_f}")
      end
    elsif(expenses[i].borrowed_from == user.id)
      unless(expenses[i].borrower == table[i+1][0] && expenses[i].borrowed_from == table[i+1][1] && expenses[i].amount == table[i+1][2].to_f)
        fail("Expense mismatch #{expenses[i].borrower.email} == #{table[i][1]} && #{expenses[i].borrowed_from.email} == #{table[i+1][0]} && #{expenses[i].amount} == #{table[i+1][2].to_f}")
      end
    end
  end
end
