require_relative 'acceptance_helper'

feature 'search content', %q(
  In order to find an answer
  As a guest
  I want to be able to search words in content of ...
) do
  given!(:user) { create :user }
  given!(:question1) { create :question, user: user, title: 'Title with test_text' }
  given!(:question2) { create :question, user: user, body: 'Body with test_text' }
  given!(:question3) { create :question, user: user, body: 'Not usefull body' }
  given!(:answer1) { create :answer, question: question1, user: user, body: 'Answer with test_text'}
  given!(:answer2) { create :answer, question: question1, user: user}
  background do
    ThinkingSphinx::Test.index

    visit root_path
  end

  scenario 'all', js: true do
    fill_in 'inclusion', with: 'test_text'
    click_on 'Поиск'

    expect(page).to have_content(question1.body)
    expect(page).to have_content(question2.body)
    expect(page).to have_content(answer1.body)
    
    expect(page).to_not have_content(question3.body)
    expect(page).to_not have_content(answer2.body)
  end

  scenario 'questions', js: true do
    fill_in 'inclusion', with: 'test_text'
    click_on 'Поиск'
    click_on 'Вопросы'

    expect(page).to have_content(question1.body)
    expect(page).to have_content(question2.body)
    
    expect(page).to_not have_content(question3.body)
    expect(page).to_not have_content(answer1.body)
    expect(page).to_not have_content(answer2.body)
  end

  scenario 'answers', js: true do
    fill_in 'inclusion', with: 'test_text'
    click_on 'Поиск'
    click_on 'Ответы'

    expect(page).to_not have_content(question1.body)

    expect(page).to have_content(answer1.body)
  end

end