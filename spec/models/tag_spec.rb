require 'spec_helper'

describe Tag do
  it { should ensure_length_of(:title).is_at_least(5).is_at_most(30) }

  it { should have_many(:taggings) }
  it { should have_many(:questions).through(:taggings) }
end
