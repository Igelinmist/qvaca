# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    password "12345678"
    password_confirmation "12345678"
    association  :profile

    after(:create) { |user| user.confirm! }
  end
end
