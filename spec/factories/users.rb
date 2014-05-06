# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    nickname "MyNick"
    first_name "Ivan"
    last_name "Ivanov"
    email "nickname@mailsrv.com"
  end
end
