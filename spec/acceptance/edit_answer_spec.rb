require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I want to be able edit answer
} do
  given!(:user) { create(:user)}
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario "Unauthenticated user try to edit question" do
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать'
  end
  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)      
    end
    scenario "can see link to Edit" do
      within '.answers' do
        expect(page).to have_link 'Редактировать'
      end
    end

    scenario "try to edit his answer", js: true do
      click_on 'Редактировать'
      within '.answers' do
        fill_in 'Ответ', with: 'Исправленный ответ'        
        click_on 'Сохранить'
        
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Исправленный ответ'
        expect(page).to_not have_selector 'textarea'
      end

    end

    scenario "try to edit other user's question" 
  end

end
