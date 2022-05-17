class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.float :amount
      t.integer :no_parts
      t.string :desc, limit: 200

      t.timestamps
    end
  end
end
