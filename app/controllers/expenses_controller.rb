class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    authorized_expense_user = Expense.joins(:user).where(["expenses.user_id = ? OR expenses.user_id = ? OR users.invited_by_id = ?",
                                            current_user.id, current_user.invited_by_id, current_user.id])
    @search = authorized_expense_user.order(created_at: 'DESC').ransack(params[:q])
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

  def destroy
    @expense = Expense.find params[:id]
    @expense.destroy
    redirect_to :back
  end

  private

  def expense_params
    params.require(:expense).permit :name,
                                    :amount,
                                    :description,
                                    :category_id,
                                    :sub_category_id
  end

  def user_has_expenses_logged
    !@expense.nil?
  end

  def authorized_user
    Expense.where(user_id: current_user.invtited_by_id)
  end

end
