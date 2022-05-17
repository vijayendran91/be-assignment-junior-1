include BillApplication
include ExpenseApplication

Given /Following users sign up/ do |table|
  table = table.raw
  contents = table.first
  (1..table.size-1).each do |i|
    begin
      create_new_user({ :first_name => table[i][0], :last_name => table[i][1],
            :email => table[i][2], :password => table[i][3],
         })
    rescue => e
      @error = e
    end
  end
end

Given("User {string} pays bill with following details") do |string, table|
  table = table.raw
  contents = table.first
  bill_arr = table.second
  paid_by = get_user_by_email(bill_arr[2])
  begin
    bill = {
      :amount => bill_arr[0],
      :no_parts => bill_arr[1],
      :paid_by => paid_by,
      :desc => bill_arr[3]
    }
    @bill = add_bill(bill)
  rescue => e
    @error = e
  end
end

Given("Expenses are added for the following people") do |table|
  table = table.raw
  contents = table.first
  participants = table.slice(1,table.length-1)
  participants_id = []
  participants.each do |email|
    participants_id.push(get_user_by_email(email)[:id])
  end
  @expenses = add_expenses(@bill, participants_id)
end

Given("Following expenses are reflected to the users") do |table|
  table = table.raw
  contents = table.first
  (1..table.size-1).each do |i|
    user = get_user_by_email(table[i][2])
    expense = get_all_expenses_of_user_id(user[:id]).first
    table[i][0].should == expense.borrowed_from.email
    table[i][1].to_f.should == expense.amount
    table[i][2].should == expense.borrower.email
  end
end
