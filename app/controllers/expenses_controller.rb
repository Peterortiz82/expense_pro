class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @search = Expense.where(user_id: current_user.id).order(created_at: 'DESC').ransack(params[:q])
    @expenses = @search.result.paginate(page: params[:page], per_page: 15)
    # respond_to do |format|
    #   format.html
    #   format.csv { render text: @expenses.to_csv }
    # end
  end

  def new
    @expense = Expense.new
    @category = Category.new
    @categories = @expense.category
  end

  def create
    @expense = Expense.new expense_params
    @expense.user_id = current_user.id
    @expense.expense_date = DateTime.now.in_time_zone.to_date
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

  def user_has_expenses_logged
    !@expense.nil?
  end

end
