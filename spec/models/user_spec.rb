require 'spec_helper'

describe User do
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :comments }
  it { should have_many :votes }
  it { should have_one :profile }
  it { should accept_nested_attributes_for :profile }
end