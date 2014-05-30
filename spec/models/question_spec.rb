require 'spec_helper'

describe Question do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }

  it { should ensure_length_of(:title).is_at_least 15 }
  it { should have_many :answers }
  it { should have_many :comments }
  it { should have_many :attachments}
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should have_many :votes }

  it { should accept_nested_attributes_for :answers }

  it { should accept_nested_attributes_for :attachments }
end
