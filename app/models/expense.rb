class Expense < ApplicationRecord
  belongs_to :borrowed_from, class_name: 'User', foreign_key: :borrowed_from_id
  belongs_to :borrower, class_name: 'User', foreign_key: :borrower_id

  belongs_to :bill
end
