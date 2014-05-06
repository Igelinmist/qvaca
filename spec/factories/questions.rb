# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    #title "MyStringFifteenMin"
    sequence(:title) {|n| "MyStringFifteenMin#{n}"}
    body "MyText"
  end
  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
  end
