module ExpenseListAnalytics

  # Returns the category that has the highest expense total =>
  # {:category=>"Household Items/Supplies", :category_count=>3, :amount=>204.0}
  #
  def most_spent_by_category
    @most_spent ||= category_data.max_by { |key| key[:amount] }
  end

  def lowest_spent_by_category
    @lowest_spent ||= category_data.min_by { |key| key[:amount] }
  end

  # This returns the total count of all categories
  # e.g food: 5, fitness: 3 => total: 8
  #
  def total_categories_count
    @cat_count ||= category_data.sum { |category| category[:category_count] }
  end

  # This returns the total count of individual categories
  # e.g food: 5, fitness: 3 => total: 2
  #
  def total_individual_categories_count
    expense_data_grouped_by_category.count
  end

  def category_percentage_chart_data
    total_categories = total_categories_count
    total_categories = 1 if total_categories == 0

    category_data.map do |category|
      [
        category[:category],
        ((category[:category_count].to_f / total_categories.to_f) * 100).round(2)
      ]
    end
  end

  # Creates all days from today's date - num_of_day_ago an expense was entered for better graphs.
  # if there were no expenses for a particular day we add 0 to that days count.
  #
  def expense_chart_data(num_of_days_ago)
    start_date = Date.current - num_of_days_ago.to_i
    end_date = Time.current.to_date
    data = []

    (start_date..end_date).each do |date|
      matching_dates = expense_data_grouped_by_expense_date.detect { |expense| expense[0] == date }
      if matching_dates.present?
        data << [date, matching_dates[1].count]
      else
        data << [date, 0]
      end
    end

    data
  end

private

  # Returns an array of hashes of category data =>
  # [{:category=>"Credit Card/Loan Payments", :category_count=>4, :amount=>125.0},
  #  {:category=>"Household Items/Supplies", :category_count=>3, :amount=>204.0},
  #  {:category=>"Insurance", :category_count=>4, :amount=>191.0}]
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

  def expense_data_grouped_by_category
    @expense_data_by_category ||=expense_data.group_by { |expense_data| expense_data[:category] }
  end

  def expense_data_grouped_by_expense_date
    @expense_data_by_date ||= expense_data.group_by { |expense| expense[:expense_date].to_date }
  end

  # Returns an array of hashes of expense data =>
  # [{:category=>"Credit Card/Loan Payments", :expense_date=>Sun, 10 Jul 2016, :amount=>45.0},
  # {:category=>"Credit Card/Loan Payments", :expense_date=>Sun, 10 Jul 2016, :amount=>33.0},
  # {:category=>"Household Items/Supplies", :expense_date=>Sun, 10 Jul 2016, :amount=>74.0},
  # {:category=>"Household Items/Supplies", :expense_date=>Sun, 10 Jul 2016, :amount=>82.0}]
  #
  def expense_data
    expenses.map do |expense|
      {
        category: expense.category.name,
        expense_date: expense.expense_date.to_date,
        amount: expense.amount
      }
    end
  end

end
