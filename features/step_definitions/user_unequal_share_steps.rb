And("A shared expense is made as following") do |table|
  table = table.raw
  contents = table.first
  participants = []
  share_perc = []
  (1..table.length-1).each do |i|
    participants.push(get_user_by_email(table[i][0]).id)
    share_perc.push(table[i][1].to_f)
  end
  add_expenses(@bill, participants, true, share_perc)
end
