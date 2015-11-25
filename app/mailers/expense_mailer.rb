class ExpenseMailer < ApplicationMailer
  default from: "no-reply@expensetracker.com"

  def daily_expense_email report, recipient
    @recipient = recipient
    @report = report
    mail(to: recipient.email, subject: "Weekly Expense Report")
  end
end
