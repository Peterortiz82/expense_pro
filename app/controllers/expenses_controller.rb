class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    authorized_expense_user = Expense.joins(:user).where(
        [
            "expenses.user_id = ? OR expenses.user_id = ? OR users.invited_by_id = ?",
            current_user.id,
            current_user.invited_by_id,
            current_user.id
        ]
    )
    @search = authorized_expense_user.ransack(params[:q])
    @expenses = @search.result.order(expense_date: "DESC").includes(:user).
        paginate(page: params[:page], per_page: 15)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new expense_params
    @expense.user_id = current_user.id
    @expense.expense_date = Time.current
    if @expense.save
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
