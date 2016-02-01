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

  belongs_to :user
  has_many :expenses

end
