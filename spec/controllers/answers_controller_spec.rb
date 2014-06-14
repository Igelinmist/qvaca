require 'spec_helper'

describe AnswersController do
  describe "GET #vote" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, question: question, user: user }

    context "with authenticated user" do
      login_user
      it "give some vote to answer" do
        # expect(get :vote, rate: 1, id: answer.id).to change(Vote, :count).by(1)
      end
    end
  end
end