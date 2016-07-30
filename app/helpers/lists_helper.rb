module ListsHelper

  def expense_line_chart(num_of_days_ago)
    line_chart [{ name: "Expenses" , data: @list.expense_chart_data(num_of_days_ago)}]
  end

  def category_pie_chart
    pie_chart @list.category_percentage_chart_data.map, width: "auto", library: { tooltip: { valueSuffix: '%' }}
  end

  def show_proper_total
    if !search? || toggle_with_no_search
      "Total Expenses: #{number_to_currency @list.total_amount}"
    elsif search?
      "Total Expenses: #{number_to_currency @search.result.sum(:amount)}"
    else
      "Total Expenses: #{number_to_currency @expenses.sum(:amount)}"
    end
  end

  def shared_by_name(list)
    User.where(id: list.list_permissions.first.permission_granted_by).first.display_name
  end

  def read_and_write_access?(list)
    permission_access = list.list_permissions.detect do |list_permission|
      list_permission.permission_granted_to == current_user.id
    end

    permission_access.read_and_write_access == true
  end

  def list_creator
    @list.user_id == current_user.id
  end

  private

  def toggle_with_no_search
    search? && params[:q].has_key?(:s) && params[:q].values.count == 1
  end

  def search?
    params[:q].present?
  end

end
