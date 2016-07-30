class ListsController < ApplicationController
  before_action :set_list, only: [:edit, :show, :destroy, :update, :analytics]
  before_action :authenticate_user!
  before_action :redirect_if_user_is_not_authorized, only: [:edit, :show, :analytics]

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

  def redirect_if_user_is_not_authorized
    unless authotized_list_user
      flash[:alert] = "You do not have access to that list!"
      redirect_to :root
    end
  end

  def authotized_list_user
    if @list.list_permissions.present?
      user_has_permissions = @list.list_permissions.detect do |permission|
        permission.permission_granted_to == current_user.id
      end
    end

    current_user.id == @list.user_id || user_has_permissions
  end

  def set_list
    @list = List.find params[:id]
  end

  def list_params
    params.require(:list).permit :title, :budget_amount
  end

end
