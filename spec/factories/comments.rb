# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyText"
    correction 1
    commentable_type "MyString"
    commentable_id 1
  end
end
