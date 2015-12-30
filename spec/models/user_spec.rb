require 'rails_helper'

describe User do

  subject { create :user }

  it { should have_many :expenses }

  it { should have_many :monthly_bills }

  it { should validate_presence_of :first_name }

  it { should validate_presence_of :last_name }

  it 'generates a display name when created' do
    expect(subject.display_name).to eq 'Test User'
  end

end