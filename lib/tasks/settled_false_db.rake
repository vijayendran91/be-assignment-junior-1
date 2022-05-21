namespace :settled_false_db do
  desc "Adds one month to the Look Subscription"

  task :add_false_to_settled => :environment do
    Expense.where(:settled => nil).each do |t|
      t.update_attribute :settled, false
    end
  end
end
