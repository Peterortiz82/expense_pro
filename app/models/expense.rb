# == Schema Information
#
# Table name: expenses
#
#  id              :integer          not null, primary key
#  name            :string
#  amount          :string
#  description     :text
#  category_id     :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sub_category_id :integer
#

class Expense < ActiveRecord::Base
  belongs_to :user
  has_many :categories

  nilify_blanks
end
