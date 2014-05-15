# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "Текст моего коммента"
    correction 1
    commentable_type "Question"
    commentable_id 1
  end

  factory :invalid_comment, class: 'Comment' do
    commentable_type "Question"
    commentable_id 1
  end
end
