require 'rails_helper'

describe SubCategory do

  it { should belong_to :sub_category }

  it { should belong_to :user }

end
