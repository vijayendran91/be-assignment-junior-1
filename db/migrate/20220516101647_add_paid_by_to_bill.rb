class AddPaidByToBill < ActiveRecord::Migration[6.1]
  def change
    add_reference :bills, :paid_by, index:true

    add_foreign_key :bills, :users, column: :paid_by_id
  end
end
