class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses = Expense.where(user_id: current_user.id).order(created_at: 'DESC')
  end

  def new
    @expense = Expense.new
    @category = Category.new
    @categories = @expense.category
  end

  def create
    @expense = Expense.new expense_params
    @expense.user_id = current_user.id
    if @expense.save
      redirect_to expenses_path
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit :name,
                                    :amount,
                                    :description,
                                    :category_id,
                                    :sub_category_id
  end

end
