class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :chronic_time_zones

  def index
    @search = Expense.where(user_id: current_user.id).order(created_at: 'DESC').search(params[:q])
    @expenses = @search.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @expense = Expense.new
    @category = Category.new
    @categories = @expense.category
  end

  def create
    @expense = Expense.new expense_params
    @expense.user_id = current_user.id
    @date = params.require(:expense).permit(:created_at)[:created_at]
    chronic_time = Chronic.parse(@date)
    adjusted_time = chronic_time.present? ? chronic_time.in_time_zone : nil
    @expense.created_at = adjusted_time
    if @expense.save
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

  def chronic_time_zones
    Chronic.time_class = Time.zone
  end

  def user_has_expenses_logged
    !@expense.nil?
  end

end
