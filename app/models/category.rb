class Category < ActiveRecord::Base
  belongs_to :expense
  has_many :sub_categories
end
