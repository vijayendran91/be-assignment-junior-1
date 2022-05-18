class SetDefaultSettledToExpense < ActiveRecord::Migration[6.1]
  def self.up
    change_column :expenses, :settled, :boolean, :default => false
  end

  def self.down
    # You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
