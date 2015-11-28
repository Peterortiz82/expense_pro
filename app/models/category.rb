# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  default_scope { order('name ASC') }

  belongs_to :expenses
  has_many :sub_categories
end
