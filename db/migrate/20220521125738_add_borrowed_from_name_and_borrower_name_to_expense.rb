class AddBorrowedFromNameAndBorrowerNameToExpense < ActiveRecord::Migration[6.1]
  def change
    add_column :expenses, :borrowed_from_name, :string
    add_column :expenses, :borrower_name, :string
  end
end
