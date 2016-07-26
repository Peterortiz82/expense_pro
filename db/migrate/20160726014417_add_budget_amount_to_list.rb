class AddBudgetAmountToList < ActiveRecord::Migration

  def change
    add_column :lists, :budget_amount, :float
  end

end
