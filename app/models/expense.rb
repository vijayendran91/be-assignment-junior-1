class Expense < ApplicationRecord
  belongs_to :borrowed_from, class_name: 'User', foreign_key: :borrowed_from_id
  belongs_to :borrower, class_name: 'User', foreign_key: :borrower_id
  validates :amount, :presence => true
  
  belongs_to :bill
  #
  # def up
  #   change_column :expenses, :settled, :boolean, default: false
  # end
  #
  # def down
  #   change_column :expenses, :settled, :boolean, default: nil
  # end

end
