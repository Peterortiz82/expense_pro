class AddFastfoodToCategory < ActiveRecord::Migration
  def change
    food = Category.find_by name: 'Food'
    SubCategory.create name: 'Fast Food', category_id: food.id if food.present?
  end
end
