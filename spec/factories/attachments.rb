# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    file File.open("#{Rails.root}/spec/spec_helper.rb")
    attachmentable nil
  end
end
