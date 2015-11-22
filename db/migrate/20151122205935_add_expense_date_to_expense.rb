class AddExpenseDateToExpense < ActiveRecord::Migration
  def up
    add_column :expenses, :expense_date, :date
  end

  def down
    remove_column :expenses, :expense_date
  end
end
