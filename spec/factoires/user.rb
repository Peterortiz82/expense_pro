FactoryGirl.define do
  factory :user do
    display_name 'Test User'
    sequence(:email){|n| "email#{n}@domain.com" }
  end
end