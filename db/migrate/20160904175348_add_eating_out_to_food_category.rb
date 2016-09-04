class AddEatingOutToFoodCategory < ActiveRecord::Migration

  def up
    category = Category.find_by(name: "Food")

    SubCategory.create!(name: "Breakfast", category_id: category.id)
    SubCategory.create!(name: "Lunch", category_id: category.id)
    SubCategory.create!(name: "Dinner", category_id: category.id)
  end

  def down
    sub_category = %w(Breakfast Lunch Dinner)
    category = Category.find_by(name: "Food")

    category.sub_categories.each do |sub|
      sub.destroy if sub_category.include?(sub.name)
    end
  end

end
