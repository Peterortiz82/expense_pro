# Destroy all categories first to remove any old categories that may have changed over time.
Category.destroy_all
SubCategory.destroy_all

# Category names
category = ['Clothing', 'Credit Card/Loan Payments','Education', 'Fitness', 'Food', 'Fun Money', 'Gifts', 'Giving',
            'Household Items/Supplies', 'Insurance', 'Kids','Medical','Personal', 'Transportation', 'Other']

# Add Category names to the db
category.each do |cat_name|
  Category.find_or_create_by({ name: cat_name })
end

# Add Sub Categories to the Categories
clothing = Category.find_by name: 'Clothing'
clothing_cat = ['Shirt', 'Pants', 'Shoes', 'Hat', 'Other']
clothing_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: clothing.id }

credit = Category.find_by name: 'Credit Card/Loan Payments'
credit_cat = ['Visa', 'Master', 'Discover', 'Amex', 'Partners', 'Chase','Other']
credit_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: credit.id }

education = Category.find_by name: 'Education'
education_cat = ['Books', 'Online Courses', 'School Supplies', 'Other']
education_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: education.id }

fitness = Category.find_by name: 'Fitness'
fitness_cat = ['Gym Membership', 'Health Products', 'Equipment', 'Other']
fitness_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: fitness.id }

food = Category.find_by name: 'Food'
food_cat = ['Groceries', 'Resturants', 'Treats', 'Other']
food_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: food.id }

fun_money = Category.find_by name: 'Fun Money'
fun_cat = ['Entertainment', 'Games', 'Eating Out', 'Night Out','Spontaneous Giving', 'Vacations', 'Other']
fun_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: fun_money.id }

gifts = Category.find_by name: 'Gifts'
gift_cat = ['Birthday', 'Anniversary', 'Wedding', 'Christmas', 'Special Occasion', 'Other']
gift_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: gifts.id }

giving = Category.find_by name: 'Giving'
giving_cat = ['Tithing', 'Offering', 'Charities', 'Homeless', 'Other']
giving_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: giving.id }

household = Category.find_by name: 'Household Items/Supplies'
household_cat = ['Toiletries', 'Laundry Detergent', 'Dishwasher Detergent', 'Cleaning Supplies', 'Tools', 'Other']
household_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: household.id }

insurance = Category.find_by name: 'Insurance'
insurance_cat = ['Health Insurance', "Homeowner's Insurance", "Renter's Insurance", 'Auto Insurance',
                 'Identity Theft Protection', 'Other']
insurance_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: insurance.id }

kids = Category.find_by name: 'Kids'
kids_cat = ['Clothes', 'Shoes', 'Toys', 'Activities', 'Other']
kids_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: kids.id }

medical = Category.find_by name: 'Medical'
medical_cat = ['Primary Care', 'Dental Care', 'Medications', 'Medical Devices', 'Other']
medical_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: medical.id }

personal = Category.find_by name: 'Personal'
personal_cat = ['Gadgets/Electronic', 'Pampering', 'Beauty Products','Self Improvement', 'Subscriptions', 'Other']
personal_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: personal.id }

# retirement = Category.find_by name: 'Retirement'
# retirement_cat = ['Financial Planning', 'Investing', 'Other']
# retirement_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: retirement.id }

# shelter = Category.find_by name: 'Shelter'
# shelter_cat = ['Mortgage/Rent', 'Household Repairs']
# shelter_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: shelter.id }

transportation = Category.find_by name: 'Transportation'
transportation_cat = ['Fuel', 'Tires', 'Car Payment','Oil Changes', 'Maintenance', 'Parking Fees', 'Repairs', 'Sun Pass/Tolls','Other']
transportation_cat.each { |cat_name| SubCategory.create name: cat_name, category_id: transportation.id }







