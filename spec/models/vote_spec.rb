require 'spec_helper'

describe Vote do
  it { should belong_to :user }
  it { should belong_to :votable }
  it { should allow_value(-2, -1, 1, 2, 3).for(:voice) }
  it { should have_db_index [:user_id, :votable_id, :votable_type] }
end
