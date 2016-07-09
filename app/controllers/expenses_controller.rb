class ExpensesController < ApplicationController
  before_action :set_list
  before_action :authenticate_user!

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new expense_params
    @expense.user_id = current_user.id
    @expense.expense_date = Time.current
    @expense.list_id = @list.id
    if @expense.save
      redirect_to list_path @list
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
    @expense.list_id = @list.id
    if @expense.save
      redirect_to list_path @list
    else
      render :past_dated
    end
  end

  def destroy
    @expense = Expense.find params[:id]
    @expense.destroy
    redirect_to list_path @list
  end

private

  def set_list
    @list = List.find params[:list_id]
  end

  def expense_params
    params.require(:expense).permit :name,
                                    :amount,
                                    :expense_date,
                                    :description,
                                    :category_id,
                                    :sub_category_id

  end

end
