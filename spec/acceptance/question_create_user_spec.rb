require_relative 'acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask the question
} do

  given(:user) { create(:user) }

  scenario "Authenticated user create the question" do
    sign_in(user)
    
    visit '/questions'
    click_on 'Разместить вопрос'
    fill_in 'Заголовок', with: 'Test question 15'
    fill_in 'Содержание', with: 'test text'
    click_on 'Разместить'    
    
    expect(page).to have_content 'Ваш вопрос успешно размещен.'
  end

  scenario "Non-authenticated user try to create question" do
    visit '/questions'
    click_on 'Разместить вопрос'

    expect(page).to have_content 'Вам необходимо войти или зарегистрироваться.'
  end

end