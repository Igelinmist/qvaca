require 'spec_helper'

feature 'Answering',%q{
  In order to share my knowledge
  As an authenticate user
  I want to public an answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticate user public an answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Ваш ответ', with: 'Мой ответ на Ваш вопрос'
    click_on 'Сохранить'

    expect(current_path).to eq question_path(question)

    within '.answer'
    expect(page).to have_content 'Мой ответ на Ваш вопрос'
  end

end