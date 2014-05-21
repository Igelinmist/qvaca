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
      click_on 'Ответить'
      fill_in 'Ответ', with: 'Мой новый ответ'
      click_on 'Сохранить'

      expect(page).to have_content 'Мой новый ответ'
    end

    scenario 'cancel public an answer', js: true do
      click_on 'Ответить'
      fill_in 'Ответ', with: 'Мой новый ответ'
      click_on 'Отмена'

      expect(page).to_not have_content 'Мой новый ответ'
    end

    scenario 'try to create invalid answer', js: true do
      click_on 'Ответить'
      click_on 'Сохранить'

      expect(page).to have_content 'Содержание не может быть пустым'
    end
  end

end
