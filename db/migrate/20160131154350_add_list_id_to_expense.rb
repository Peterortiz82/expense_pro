class AddListIdToExpense < ActiveRecord::Migration

  def change
    add_column :expenses, :list_id, :integer
  end

end
