module ListsHelper

  def expense_line_chart(num_of_days_ago)
    line_chart [{ name: "Expenses" , data: @list.expense_chart_data(num_of_days_ago)}]
  end

  def category_pie_chart
    pie_chart @list.category_percentage_chart_data, width: "600px"
  end

  def show_proper_total
    if !search? || toggle_with_no_search
      "Total: #{number_to_currency @list.total_amount}"
    elsif search?
      "Total: #{number_to_currency @search.result.sum(:amount)}"
    else
      "Total: #{number_to_currency @expenses.sum(:amount)}"
    end
  end

  private

  def toggle_with_no_search
    search? && params[:q].has_key?(:s) && params[:q].values.count == 1
  end

  def search?
    params[:q].present?
  end

end
