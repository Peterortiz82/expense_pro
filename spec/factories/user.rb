FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    password "secret_password"
    password_confirmation "secret_password"
    sequence(:email){|n| "email#{n}@domain.com" }
  end
end