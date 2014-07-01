require 'spec_helper'

describe Answer do
  it { should belong_to :user }
  it { should belong_to :question }
  it { should have_db_index :user_id }
  it { should have_db_index :question_id }
  it { should have_many :comments }
  it { should have_many :attachments }
  it { should have_many :votes }

  it { should validate_presence_of :user_id }

  it { should accept_nested_attributes_for :attachments }

  describe '#make_the_best_answer' do
    let!(:users) { create_pair :user }
    let!(:question) { create :question, user: users[0] }
    let!(:answer) { create :answer, question: question, user: users[1] }

    it 'author of answer takes +3 poits for best answer' do
      answer.make_the_best
      # 1 for answer + 1 for first answer + 3 for the best
      expect(answer.user.profile.rating).to eq 5
    end
  end

end
