class AddBillToExpense < ActiveRecord::Migration[6.1]
  def change
    add_reference :expenses, :bill, index:true


    add_foreign_key :expenses, :bills, column: :bill_id
  end
end
