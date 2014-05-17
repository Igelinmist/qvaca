require 'spec_helper'

describe Question do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }

  it { should ensure_length_of(:title).is_at_least 15 }
  it { should have_many :answers }
  it { should have_many :comments }
  it { should have_and_belong_to_many :tags }
  it { should accept_nested_attributes_for :answers }
end
