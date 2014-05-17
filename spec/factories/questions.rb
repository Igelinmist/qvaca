# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    sequence(:title) {|n| "MyStringFifteenMin#{n}"}
    body "Текст моего вопроса"
    user_id 1
  end
  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
  end
