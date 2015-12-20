class MonthlyBillsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorized_user = MonthlyBill.joins(:user).where(
        [
              "monthly_bills.user_id = ? OR monthly_bills.user_id = ? OR users.invited_by_id = ?",
              current_user.id,
              current_user.invited_by_id,
              current_user.id
        ]
    )
    @search = authorized_user.order(due_date: "ASC").ransack(params[:q])
    @monthly_bills = @search.result.includes(:user).paginate(page: params[:page], per_page: 15)
  end

  def new
    @monthly_bill = MonthlyBill.new
  end

  def create
    @monthly_bill = MonthlyBill.new monthly_bill_params
    @monthly_bill.user_id = current_user.id
    if @monthly_bill.save
      redirect_to monthly_bills_path
    else
      render :new
    end
  end

  def destroy
    @monthly_bill = MonthlyBill.find params[:id]
    @monthly_bill.destroy
    redirect_to :back
  end

  private

  def monthly_bill_params
    params.require(:monthly_bill).permit :name,
                                         :person,
                                         :amount,
                                         :due_date
  end
end
