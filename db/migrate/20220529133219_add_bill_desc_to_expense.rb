class AddBillDescToExpense < ActiveRecord::Migration[6.1]
  def change
    add_column :expenses, :bill_desc, :string, :default => "NA"
  end
end
