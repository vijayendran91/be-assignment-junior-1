class AddTotalOweAndTotalOwedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_owe, :float
    add_column :users, :total_owed, :float
  end
end
