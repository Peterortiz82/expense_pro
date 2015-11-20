class AddSubCategoryIdToExpense < ActiveRecord::Migration
  def up
    add_column :expenses, :sub_category_id, :integer
  end

  def down
    remove_column :expenses, :sub_category_id
  end
end
