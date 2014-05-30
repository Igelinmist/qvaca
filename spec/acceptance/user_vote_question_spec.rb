require_relative 'acceptance_helper'

feature 'Vote about question', %(
  In order to keep my oppinion about question
  As an authenticate user
  I want to be able vote question
) do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }

  context 'User (not author)' do
    before { sign_in users[1] }

    scenario 'give like to question', js: true do
      visit question_path question
      within '.js-reputation' do
        click_on 'Нравится'
        expect(page).to_not have_link 'Нравится', href: like_question_path(question)
      end
    end

    scenario 'give dislike to question', js: true do
      visit question_path question
      within '.js-reputation' do
        click_on 'Не нравится'
        expect(page).to_not have_link 'Нравится'
      end
    end
  end

  scenario 'Author not see links to vote under his question' do
    sign_in users[0]
    visit question_path question

    within '.js-question' do
      expect(page).to_not have_link 'Нравится'
      expect(page).to_not have_link 'Не нравится'
    end
  end
end
