module ExpenseListAnalytics

  def total_amount
    expenses.sum(:amount)
  end

  def max_expense
    expenses.map(&:amount).max
  end

  def category_percentage_data
    total_categories = total_categories_count
    total_categories = 1 if total_categories == 0

    category_data.map do |category|
      {
          category: category[:category],
          percentage: (category[:category_count].to_f / total_categories.to_f) * 100
      }
    end
  end

  # Returns the category that has the highest expense total =>
  # {:category=>"Household Items/Supplies", :category_count=>3, :amount=>204.0}
  #
  def most_spent_by_category
    category_data.max_by { |key| key[:amount] }
  end

  # Returns an array of hashes of category data =>
  # [{:category=>"Credit Card/Loan Payments", :category_count=>4, :amount=>125.0},
  #  {:category=>"Household Items/Supplies", :category_count=>3, :amount=>204.0},
  #  {:category=>"Insurance", :category_count=>4, :amount=>191.0},
  #  {:category=>"Fun Money", :category_count=>3, :amount=>177.0},
  #  {:category=>"Transportation", :category_count=>1, :amount=>94.0},
  #  {:category=>"Giving", :category_count=>1, :amount=>66.0},
  #  {:category=>"Other", :category_count=>2, :amount=>105.0}]
  #
  def category_data
    expense_data_grouped_by_category.map do |category|
      {
          category: category[0],
          category_count: category[1].count,
          amount: category[1].sum { |category_hash| category_hash[:amount] }
      }
    end
  end

private

  def total_categories_count
    category_data.sum { |category| category[:category_count] }
  end

  def expense_data_grouped_by_category
    expense_data.group_by { |expense_data| expense_data[:category] }
  end

  # Returns an array of hashes of expense data =>
  # [{:category=>"Credit Card/Loan Payments", :sub_category=>"Other", :amount=>45.0},
  #  {:category=>"Credit Card/Loan Payments", :sub_category=>"Amex", :amount=>33.0},
  #  {:category=>"Household Items/Supplies", :sub_category=>"Cleaning Supplies", :amount=>74.0},
  #  {:category=>"Household Items/Supplies", :sub_category=>"Garbage Can", :amount=>82.0},
  #  {:category=>"Insurance", :sub_category=>"Other", :amount=>38.0}]
  #
  def expense_data
    expenses.map do |expense|
      {
        category: expense.category.name,
        # sub_category: expense.sub_category.name,
        amount: expense.amount
      }
    end
  end

end
