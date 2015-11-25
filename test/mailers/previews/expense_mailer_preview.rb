# Preview all emails at http://localhost:3000/rails/mailers/expense_mailer
class ExpenseMailerPreview < ActionMailer::Preview

  def expense_mail_preview
    ExpenseMailer.daily_expense_email(Expense.where("expense_date >= ?", Time.zone.now.beginning_of_day).
                                           order(created_at: 'DESC'), User.first)
  end

end
