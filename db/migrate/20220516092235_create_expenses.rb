class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.float :amount
      t.boolean :settled
      t.string :notes, limit: 150

      t.timestamps
    end
  end
end
