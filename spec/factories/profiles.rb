# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    display_name "MyString"
    real_name "MyString"
    website "MyString"
    location "MyString"
    birthday "2014-06-09"
    about_me "MyText"
    weekly_email false
    avatar "MyString"
    user nil
  end
end
