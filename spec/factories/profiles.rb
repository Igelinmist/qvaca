# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    display_name "Batman"
    real_name "Smith"
    website "www.night.com"
    location "Underhil"
    birthday "2014-06-09"
    about_me "MyText"
    weekly_email false
    avatar "MyString"
    user nil
  end
end
