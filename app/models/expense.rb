# == Schema Information
#
# Table name: expenses
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  category_id     :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sub_category_id :integer
#  amount          :float
#  expense_date    :datetime
#  list_id         :integer
#

class Expense < ActiveRecord::Base
  after_create :add_expense_name
  validates :amount, presence: true
  validates :description, length: { maximum: 55 }

  belongs_to :user
  belongs_to :list
  belongs_to :category
  belongs_to :sub_category

  nilify_blanks

  default_scope { order('expense_date DESC') }

  ransacker :expense_date, type: :date do
    Arel.sql('DATE(expenses.expense_date)')
  end
  
private

  def add_expense_name
    update_attributes(name: expense_name) if name.blank?
  end

  def expense_name
    category = Category.find_by(id: category_id)
    sub_category = SubCategory.find_by(id: sub_category_id)

    "#{category.name} - #{sub_category.name}"
  end

end
