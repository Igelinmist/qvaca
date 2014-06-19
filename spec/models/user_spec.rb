require 'spec_helper'

describe User do
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :comments }
  it { should have_many :votes }
  it { should have_one :profile }
  it { should have_many :authorizations }
  it { should accept_nested_attributes_for :profile }
  it { should accept_nested_attributes_for :authorizations }

  describe '#points_for_answer' do
    let!(:users) { create_pair :user }
    let!(:question) { create :question, user: users[0] }
    let!(:answer_first) { create :answer, question: question, user: users[1] }
    let!(:answer_own) { create :answer, question: question, user: users[0] }

    it 'must calculate count of answers for user' do
      expect(users[0].points_for_answer).to eq 1
    end
  end

  describe '#points_for_first_answer' do
    let!(:user) { create :user }
    let!(:question) { create :question, user: user }
    let!(:first_answers) { create :answer, question: question, user: user }
    let!(:answer) { create :answer, question: question, user: user }

    it 'must calculate count of first answers for user' do
      expect(user.points_for_first_answer).to eq 1
    end
  end

  describe '#points_for_answer_own_question' do
    let!(:users) { create_pair :user }
    let!(:own_question) { create :question, user: users[0] }
    let!(:other_question) { create :question, user: users[1] }
    let!(:answers_on_own) { create :answer, question: own_question, user: users[0] }
    let!(:answers_on_other) { create :answer, question: other_question, user: users[0] }

    it 'must calculate count of first answers for user' do
      expect(users[0].points_for_answer_own_question).to eq 1
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create :user }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has no authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end
      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }
        it 'create new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end
        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end
        it 'fills user email' do
          user = User.find_for_oauth(auth)

          expect(user.email).to eq auth.info[:email]
        end
        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end
        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
      context "provider doesn't give an email address" do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: {}) }
        it 'must return nil value for user' do
          expect(User.find_for_oauth(auth)).to eq nil
        end
      end
    end
  end
end