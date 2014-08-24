require 'spec_helper'

describe Question do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should ensure_length_of(:title).is_at_least 15 }
  it { should have_many :answers }
  it { should have_many :comments }
  it { should have_many :attachments}
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should have_many :votes }

  it { should accept_nested_attributes_for :answers }

  it { should accept_nested_attributes_for :attachments }

  describe 'reputation' do
    let(:user) { create(:user) }
    subject { build(:question, user: user) }

    it 'should calculate reputation after creating' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'should not calculate reputation after update' do
      subject.save!
      expect(Reputation).to_not receive(:calculate)
      subject.update(body: '123')
    end

    it 'should save user reputation' do
      allow(Reputation).to receive(:calculate).and_return(5)
      expect { subject.save! }.to change(user, :reputation).by(5)
    end

    it 'test double' do
      question = double(Question, title: '123')
      allow(Question).to receive(:find) { question }
      expect(Question.find(1).title).to eq '123'
    end

    it 'test time' do
      now = Time.now.utc
      allow(Time).to receive(:now) { now }
      subject.save!

      expect(subject.created_at).to eq now
    end
  end

end
