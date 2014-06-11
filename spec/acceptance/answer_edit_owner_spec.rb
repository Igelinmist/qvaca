require_relative 'acceptance_helper'

feature 'Answer editing', %q(
  In order to fix mistake
  As an author of answer
  I want to be able edit answer
) do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }
  given!(:answer1) { create(:answer, question: question, user: users[0]) }
  given!(:answer2) { create(:answer, question: question, user: users[1]) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)
    within '.js-answers' do
      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe 'Authenticated user' do
    before do
      sign_in(users[0])
      visit question_path(question)
    end

    scenario 'try to cancel edit answer', js: true do
      within "#js-answer-#{answer1.id}" do
        click_on 'Редактировать'
        fill_in 'Ответ', with: 'Исправленный ответ'
        click_on 'Отмена'
        expect(page).to_not have_content 'Исправленный ответ'
      end
    end

    scenario 'try to edit his answer', js: true do
      within "#js-answer-#{answer1.id}" do
        click_on 'Редактировать'
        fill_in 'Ответ', with: 'Исправленный ответ'
        click_on 'Сохранить'
      end

      within "#js-answer-#{answer2.id} .edit-answer-form" do
        expect(page).to_not have_selector 'textarea'
      end
      expect(page).to have_content 'Исправленный ответ'
    end

    scenario 'other user not see an edit link' do
      visit question_path question
      within "#js-answer-#{answer2.id}" do
        expect(page).to_not have_link 'Редактировать'
      end
    end
  end

end
