require_relative 'acceptance_helper'

feature 'Answering', %q(
  In order to share my knowledge
  As an authenticate user
  I want to public an answer
) do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticate user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'public an answer', js: true do
      fill_in 'Ответ', with: 'Мой новый ответ'
      click_on 'Сохранить'

      expect(page).to have_content 'Мой новый ответ'
      within('form#new_answer') do
        expect(page).to_not have_content 'Мой новый ответ'
      end
    end

    scenario 'cancel public an answer', js: true do
      fill_in 'Ответ', with: 'Мой новый ответ'
      click_on 'Отмена'

      within('form#new_answer') do
        expect(page).to_not have_content 'Мой новый ответ'
      end
    end

    scenario 'try to create invalid answer', js: true do
      within('form#new_answer') do
        click_on 'Сохранить'
      end

      expect(page).to have_content 'Содержание не может быть пустым'
    end
  end

end
