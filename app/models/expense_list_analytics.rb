module ExpenseListAnalytics

  def total_amount
    expenses.sum(:amount)
  end

  def max_expense
    expenses.map(&:amount).max
  end

  def category_data
    categories = expense_data.group_by { |expense_data| expense_data[:category] }

    categories.map do |cat|
      {
          category: cat[0],
          category_count: cat[1].count,
          amount: cat[1].sum { |cat_hash| cat_hash[:amount] }
      }
    end
  end

private

  def expense_data
    expenses.map do |expense|
      {
        category: expense.category.name,
        sub_category: expense.sub_category.name,
        amount: expense.amount
      }
    end
  end

end
