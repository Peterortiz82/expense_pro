# == Schema Information
#
# Table name: monthly_bills
#
#  id         :integer          not null, primary key
#  name       :string
#  person     :string
#  amount     :float
#  due_date   :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MonthlyBillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
