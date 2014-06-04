require_relative 'acceptance_helper'

feature 'Vote about answer', %(
  In order to keep my like about answer
  As an authenticate user
  I want to be able vote answer
) do

  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: users[0]) }

  context 'User (not author)' do
    before do
      sign_in users[1]
      visit question_path question
    end

    scenario 'give like to answer', js: true do
      within "#js-answer-#{answer.id}" do
        click_on 'Нравится'
        expect(page).to_not have_link 'Нравится', href: like_answer_path(answer)
      end
    end

    scenario 'give dislike to question', js: true do
      within "#js-answer-#{answer.id}" do
        click_on 'Не нравится'
        expect(page).to_not have_link 'Не нравится'
      end
    end
  end

  scenario 'Author not see links to vote under his answer' do
    sign_in users[0]
    visit question_path question

    within "#js-answer-#{answer.id}" do
      expect(page).to_not have_link 'Нравится'
      expect(page).to_not have_link 'Не нравится'
    end
  end
end
