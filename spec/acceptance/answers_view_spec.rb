require_relative 'acceptance_helper'

feature 'view answers',%q{
  In order to read answers
  As a guest
  I want to be able view answers on question
} do
  given(:question) {create :question}

  scenario "a guest visit detail of question and see answers" do
    question.answers.create(body: 'Мой ответ')
    visit question_path question

    expect(page).to have_content('Мой ответ')
  end
end