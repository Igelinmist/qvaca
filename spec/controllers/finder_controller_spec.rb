require 'spec_helper'

describe FinderController do
  let!(:user) {create(:user)}
  let!(:question1) {create(:question, body: "Вопрос по программированию Ruby On Rails приложений", user: user)}
  let!(:question2) {create(:question, body: "Вопрос по программированию на языке Ruby", user: user)}
  let!(:question3) {create(:question, body: "Вопрос по программированию на C++", user: user)}

  describe 'GET #search' do
    context 'Content contain the searching string' do
      it 'loads result of search into @result' do
        ThinkingSphinx::Test.index
        get :search, inclusion: 'Ruby', within: 'questions'
        expect(assigns(:result)).to eq [question1, question2]
        expect(assigns(:result)).to_not eq [question3]
      end
    end
  end

end
