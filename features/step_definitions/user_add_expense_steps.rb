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
  @bill = nil
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
  @expenses = []
  participants = []
  participants = table.slice(1,table.length-1)
  participants_id = []
  participants.each do |email|
    participants_id.push(get_user_by_email(email)[:id])
  end
  @expenses = add_expenses(@bill, participants_id, false, [])
end

Given("Following expenses are reflected to the users") do |table|
  table = table.raw
  contents = table.first
  (1..table.size-1).each do |i|
    user = get_user_by_email(table[i][1])
    amount = get_total_expense_of_user_id(user[:id])
    table[i][0].to_f.should == amount
  end
end
