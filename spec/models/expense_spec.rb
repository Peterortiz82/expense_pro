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
#  list_id         :integer
#

require 'rails_helper'

describe Expense do

  it { should belong_to :user }

  it { should belong_to :category }

  it { should belong_to :sub_category }

  it { should validate_presence_of :amount }

  it { should validate_length_of(:description).is_at_most(55).on(:create) }

end
