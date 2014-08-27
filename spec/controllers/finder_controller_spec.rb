require 'spec_helper'

describe FinderController do
  let(:user) {create(:user)}
  let!(:question1) {create(:question, body: "Вопрос по программированию Ruby On Rails приложений", user: user)}
  let!(:question2) {create(:question, body: "Вопрос по программированию на языке Ruby", user: user)}
  let!(:question3) {create(:question, body: "Вопрос по программированию на C++", user: user)}

  describe 'GET #search' do
    context 'Content contain the searching string' do
      it 'finds questions' do
        ThinkingSphinx::Test.index
        get :search, search: 'Ruby', within: 'questions'
        expect(@result).to contain [quesion1, question2]
        expect(@result).to_not contain [question3]
      end
    end
  end

end
