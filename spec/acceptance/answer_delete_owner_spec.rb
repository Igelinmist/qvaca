require_relative 'acceptance_helper'

feature 'Owner delete answer', %q(
  In order to clear topic from bad or duplicate answer
  As an author of answer
  I want be able to delete answer
) do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }
  given!(:answer1) { create(:answer, question: question, user: users[0]) }
  given!(:answer2) { create(:answer, question: question, user: users[1]) }

  scenario 'User not see delete link for answers of another user', js: true do
    sign_in(users[0])
    visit question_path(question)

    within "#js-answer-#{answer2.id}" do
      expect(page).to_not have_link 'Удалить'
    end
  end

  scenario 'Authenticated user delete his answer' do
    sign_in(users[0])
    visit question_path(question)
    within "#js-answer-#{answer1.id}" do
      click_on 'Удалить'
    end
    expect(page).to have_content 'Ваш ответ удален.'
  end
end
