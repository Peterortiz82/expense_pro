class AddEatingOutToFoodCategory < ActiveRecord::Migration

  def up
    SubCategory.create!(name: "Breakfast", category_id: 5)
    SubCategory.create!(name: "Lunch", category_id: 5)
    SubCategory.create!(name: "Dinner", category_id: 5)
  end

  def down
    sub_category = %w(Breakfast Lunch Dinner)
    category = Category.find 5

    category.sub_categories.each do |sub|
      sub.destroy if sub_category.include?(sub.name)
    end
  end

end
