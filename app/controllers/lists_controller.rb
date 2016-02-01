class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = List.all.order(created_at: :desc)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new list_params
    @list.user_id = current_user.id
    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def show
    @list = List.find params[:id]
    @expenses = Expense.where list_id: @list.id
    @search = authorized_expense_user.ransack(params[:q])
    @expense = @search.result.order(expense_date: "DESC").includes(:user).
        paginate(page: params[:page], per_page: 15)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def authorized_expense_user
    Expense.joins(:user).where(
        [
            "expenses.user_id = ? OR expenses.user_id = ? OR users.invited_by_id = ?",
            current_user.id,
            current_user.invited_by_id,
            current_user.id
        ]
    )
  end

  def list_params
    params.require(:list).permit :title
  end

end
