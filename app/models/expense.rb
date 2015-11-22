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
#

class Expense < ActiveRecord::Base
  validates :amount, presence: true

  belongs_to :user
  belongs_to :category
  belongs_to :sub_category

  nilify_blanks

  ransacker :created_at do
    Arel.sql('date(expenses.created_at)')
  end

end
