# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  first_name             :string
#  last_name              :string
#  display_name           :string
#

require 'rails_helper'

describe User do

  subject { create :user }

  it { should have_many :expenses }

  it { should have_many :monthly_bills }

  it { should validate_presence_of :first_name }

  it { should validate_presence_of :last_name }

  it "generates a display name when created" do
    expect(subject.display_name).to eq 'Test User'
  end

end
