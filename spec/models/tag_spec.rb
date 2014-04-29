require 'spec_helper'

describe Tag do
  it {should ensure_length_of(:title).is_at_least(5).is_at_most(30)}
end
