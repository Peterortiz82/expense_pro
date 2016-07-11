class ListsController < ApplicationController
  before_action :set_list, only: [ :edit, :show, :destroy, :update]
  before_action :authenticate_user!

  def index
    @lists = authorized_list_user.paginate(page: params[:page], per_page: 15)
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
    @expenses = @list.expenses
    @sum_of_expenses = @expenses.sum(:amount)
    @search = @expenses.ransack(params[:q])
    @expenses = @search.result.order(expense_date: "DESC").includes(:user).paginate(page: params[:page], per_page: 15)
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

private

  def set_list
    @list = List.find params[:id]
  end

  def authorized_list_user
    List.joins(:user).where(
        [
            "lists.user_id = ? OR lists.user_id = ? OR users.invited_by_id = ?",
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
