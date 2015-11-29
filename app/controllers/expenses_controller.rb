class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @authorized_expense_user = Expense.joins(:user).where(["expenses.user_id = ? OR expenses.user_id = ? OR users.invited_by_id = ?",
                                            current_user.id, current_user.invited_by_id, current_user.id])
    @search = @authorized_expense_user.order(expense_date: 'DESC').ransack(params[:q])
    @expenses = @search.result.includes(:user).paginate(page: params[:page], per_page: 15)
  end

  def new
    @expense = Expense.new
    @category = Category.new
    @categories = @expense.category
  end

  def create
    # recipient = User.where(invited_by_id: current_user.id)
    # report = Expense.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @expense = Expense.new expense_params
    @expense.user_id = current_user.id
    @expense.expense_date = DateTime.now.in_time_zone.to_date
    if @expense.save
      # ExpenseMailer.daily_expense_email(report, recipient).deliver_now
      redirect_to expenses_path
    else
      render :new
    end
  end

  def past_dated
    @expense = Expense.new
  end

  def do_past_dated
    @expense = Expense.new expense_params
    @expense.user_id = current_user.id
    # @sale_date = params.require(:expense).permit(:expense_date)
    # chronic_time = Chronic.parse(@sale_date)
    # adjusted_time = chronic_time.present? ? chronic_time.in_time_zone : nil
    # @expense.expense_date = adjusted_time
    if @expense.save
      redirect_to expenses_path
    else
      render :past_dated
    end
  end

  def destroy
    @expense = Expense.find params[:id]
    @expense.destroy
    redirect_to :back
  end

  private

  def expense_params
    params.require(:expense).permit :name,
                                    :amount,
                                    :expense_date,
                                    :description,
                                    :category_id,
                                    :sub_category_id
  end

end
