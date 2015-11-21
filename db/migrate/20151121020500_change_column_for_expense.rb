class ChangeColumnForExpense < ActiveRecord::Migration
  def up
    remove_column :expenses, :amount
    add_column :expenses, :amount, :float
  end

  def down
    add_column :expenses, :amount, :string
    remove_column :expenses, :amount
  end
end
