module ApplicationHelper

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
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
