# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:nickname) {|n| "Nickname#{n}"}
    sequence(:email) {|n| "nickname#{n}@mailsrv.com"}
    first_name "Ivan"
    last_name "Ivanov"
  end
end
