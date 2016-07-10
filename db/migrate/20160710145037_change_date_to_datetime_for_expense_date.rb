class ChangeDateToDatetimeForExpenseDate < ActiveRecord::Migration

  def up
    change_column :expenses, :expense_date, :datetime
  end

  def down
    change_column :expenses, :expense_date, :date
  end

end
