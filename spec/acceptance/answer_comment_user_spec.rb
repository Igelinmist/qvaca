require_relative 'acceptance_helper'

feature 'User can comment answer', %q(
  In order to leave note to answer
  As an authenticate user
  I want to comment the answer
) do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'user can public comment', js: true do
    sign_in(user)
    visit question_path question
    within "#js-answer-#{answer.id}" do
      click_on 'Комментировать'
      fill_in 'Ваш комментарий:', with: 'Мой комментарий'
      click_on 'Сохранить'

      expect(page).to have_content 'Мой комментарий'
    end

  end

  scenario "guest can't comment answer" do
    visit question_path question

    within "#js-answer-#{answer.id}" do
      expect(page).to_not have_link 'Комментировать'
    end
  end
end
