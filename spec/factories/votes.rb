# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    voice 1
    user nil
    votable nil
  end
end
