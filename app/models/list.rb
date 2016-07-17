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

  default_scope { order('created_at DESC') }

  validates :title, presence: true

end
