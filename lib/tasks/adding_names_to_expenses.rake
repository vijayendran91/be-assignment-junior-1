namespace :adding_names_to_expense do
  desc "Adds first names of borrowed_from and borrower to expense table"

  task :add_name_to_expense => :environment do
    Expense.all().each do |t|
      borrowed_from_name = t.borrowed_from[:first_name]
      borrower_name = t.borrower[:first_name]
      binding.pry
      t.update_attribute :borrowed_from_name, borrowed_from_name
      t.update_attribute :borrower_name, borrower_name
    end
  end
end
