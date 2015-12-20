class ChangeExpenseDateColumnInExpense < ActiveRecord::Migration
  def up
    change_column :expenses, :expense_date, :date
  end

  def down
    change_column :expenses, :expense_date, :datetime
  end
end
