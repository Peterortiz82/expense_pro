class ListsController < ApplicationController

  before_action :set_list, only: [:edit, :show, :destroy, :update, :analytics, :line_chart, :pie_chart]
  before_action :authenticate_user!

  def index
    @lists = current_user.lists.paginate(page: params[:page], per_page: 15)
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
    @list_expenses = @list.expenses
    @search = @list_expenses.ransack(params[:q])
    @expenses = @search.result.paginate(page: params[:page], per_page: 15)
  end

  def analytics
    @days = params[:days_ago] || (Date.current - @list.expenses.map(&:expense_date).min.to_date).to_i
  end

  def line_chart
  end

  def pie_chart
  end

  def shared_lists
    @shared_lists = permissions_granted_lists.paginate(page: params[:page], per_page: 15)
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

  def permissions_granted_lists
    lists = []

    permissions_lists_for_current_user.select do |permissions|
      list = List.where(id: permissions.list_id)
      lists << list.first
    end

    lists
  end

  def permissions_lists_for_current_user
    ListPermission.where(permission_granted_to: current_user.id)
  end

  def list_params
    params.require(:list).permit :title, :budget_amount
  end

end
