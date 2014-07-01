require 'spec_helper'

describe Vote do
  it { should belong_to :user }
  it { should belong_to :votable }
  it { should allow_value(-2, -1, 1, 2, 3).for(:voice) }
  it { should have_db_index [:user_id, :votable_id, :votable_type] }

  describe '.vote_rate' do
    let!(:users) { create_pair :user }
    let!(:question) { create :question, user: users[0] }
    let!(:answer) { create :answer, question: question, user: users[1] }

    it 'author takes +2 poits for positive question vote' do
      question.vote(users[1], 1)
      
      expect(Vote.vote_rate(users[0])).to eq 2
    end

    it 'author takes -2 poits for negative question vote' do
      question.vote(users[1], -1)
      
      expect(Vote.vote_rate(users[0])).to eq -2
    end

    it 'author takes +1 poits for positive answer vote' do
      answer.vote(users[0], 1)
      
      expect(Vote.vote_rate(users[1])).to eq 1
    end

    it 'author takes -1 poits for negative answer vote' do
      answer.vote(users[0], -1)
      
      expect(Vote.vote_rate(users[1])).to eq -1
    end

  end
end
