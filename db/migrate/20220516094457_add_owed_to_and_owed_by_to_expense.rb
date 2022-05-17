class AddOwedToAndOwedByToExpense < ActiveRecord::Migration[6.1]
  def change
    add_reference :expenses, :borrowed_from, null: false
    add_reference :expenses, :borrower, null: false

    add_foreign_key :expenses, :users, column: :borrowed_from_id
    add_foreign_key :expenses, :users, column: :borrower_id

  end
end
