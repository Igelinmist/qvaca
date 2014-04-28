require 'spec_helper'

describe Question do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should ensure_length_of(:title).is_at_least(15) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should have_and_belong_to_many(:tags) }
end
