# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    voice 1
    user 1
    votable_type 'Question'
    votable_id 1
  end
end
