require_relative 'acceptance_helper'

feature 'view answers', %q(
  In order to read answers
  As a guest
  I want to be able view answers on question
) do
  given!(:user) { create :user }
  given!(:question) { create :question, user: user }
  given!(:answer) { create :answer, question: question, user: user }

  scenario 'a guest visit detail of question and see answers' do
    visit question_path question

    expect(page).to have_content('Текст моего ответа')
  end
end
