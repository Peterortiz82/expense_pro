# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class List < ActiveRecord::Base
  include ExpenseListAnalytics

  belongs_to :user
  has_many :expenses
  has_many :list_permissions

  default_scope { order('created_at DESC') }

  validates :title, presence: true

  def has_budget?
    budget_amount.present?
  end

  def remaining_budget
    return unless has_budget?

    budget_amount - total_amount
  end

  def total_amount
    expenses.map(&:amount).sum
  end

  def max_expense
    expenses.map(&:amount).max
  end

end
