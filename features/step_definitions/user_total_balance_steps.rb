And("User {string} has the following in his dashboard") do |email, table|
  table = table.raw
  contents = table.first
  user = get_user_by_email(email)
  unless(user.total_owe == nil)
    user.total_owe.should == table[1][0].to_f
  end

  unless (user.total_owed == nil)
    user.total_owed.should == table[1][1].to_f
  end
end
