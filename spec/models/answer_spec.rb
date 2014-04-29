require 'spec_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should have_db_index(:question_id) }
  it { should have_many(:comments) }  
end
