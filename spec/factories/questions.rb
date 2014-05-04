# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "MyStringMyStringMyString"
    body "MyText"
    votes 1
    views 1
    end
  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    votes nil
    views nil
  end
end
