class ExpensesController < ApplicationController
  before_action :set_list
  before_action :set_expense, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @all_expenses = @list.expenses
    @search = @all_expenses.ransack(params[:q])
    @expenses = @search.result.paginate(page: params[:page], per_page: 15)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new expense_params
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
    @expense.list_id = @list.id
    if @expense.save
      redirect_to list_path @list
    else
      render :past_dated
    end
  end

  def edit
    redirect_if_user_is_not_authorized
  end

  def update
    if @expense.update(expense_params)
      redirect_to list_path @list
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to list_path @list
  end

private

  def redirect_if_user_is_not_authorized
    unless authotized_list_user
      flash[:alert] = "You do not have access to that list!"
      redirect_to :root
    end
  end

  def authotized_list_user
    if @expense.list.list_permissions.present?
      user_has_permissions = @list.list_permissions.detect do |permission|
        permission.permission_granted_to == current_user.id
      end
    end

    current_user.id == @list.user_id || user_has_permissions
  end

  def set_expense
    @expense = Expense.find params[:id]
  end

  def set_list
    @list = List.find params[:list_id]
  end

  def expense_params
    params.require(:expense).permit :name, :amount, :expense_date,
                                    :description, :category_id, :sub_category_id

  end

end
