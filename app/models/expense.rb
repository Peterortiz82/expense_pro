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
#  expense_date    :date
#

class Expense < ActiveRecord::Base
  validates :amount, presence: true

  belongs_to :user
  belongs_to :category
  belongs_to :sub_category

  nilify_blanks

  ransacker :expense_date do
    Arel.sql('date(expense_date)')
  end

  # def self.to_csv
  #   CSV.generate do |csv|
  #     csv << column_names
  #     all.each do |expense|
  #       csv << expense.attributes.values_at(*column_names)
  #     end
  #   end
  # end

end
