require_relative 'acceptance_helper'

feature 'Question editing', %q{
  In order to fix mistake
  As an author of Question
  I want to be able to edit Question
} do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }

  scenario "User who isn't an author of question not see link on edit" do
    sign_in(users[1])
    visit question_path question
    within '#js-question' do 
      expect(page).to_not have_link 'Редактировать'
    end
  end

  scenario "Guest not see link on edit" do
    visit question_path question
    within '#js-question' do
      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe "Author sign in " do
    before do
      sign_in(users[0])
      visit question_path(question)
    end

    scenario "edit question and try to cancel edit question" do
      within '#js-question' do
        click_on 'Редактировать'
      end
      fill_in 'Заголовок', with: 'Исправленный заголовок'
      fill_in 'Содержание', with: 'Исправленный вопрос'
      click_on 'Отмена'

      within '#js-question' do
        expect(page).to_not have_content 'Исправленный вопрос'
      end
    end

    scenario "try to edit and save question" do
      old_question = question.body
      within '#js-question' do
        click_on 'Редактировать'
      end
      fill_in 'Заголовок', with: 'Исправленный заголовок'
      fill_in 'Содержание', with: 'Исправленный вопрос'
      click_on 'Сохранить'
        
      within '#js-question' do
        expect(page).to have_content 'Исправленный вопрос'
        expect(page).to_not have_content old_question 
        expect(page).to_not have_selector 'textarea'
      end
    end
    
  end
end