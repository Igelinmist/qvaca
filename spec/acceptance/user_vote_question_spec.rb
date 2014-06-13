require_relative 'acceptance_helper'

feature 'Vote about question', %(
  In order to keep my like about question
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
        click_link 'question-vote-up'
        expect(page).to_not have_link 'question-vote-up', href: voteup_question_path(question)
        expect(page).to have_content '2'
      end
    end

    scenario 'give dislike to question', js: true do
      visit question_path question
      within '.js-reputation' do
        click_link 'question-vote-down'
        expect(page).to_not have_link 'question-vote-down'
      end
    end
  end

  scenario 'Author not see links to vote under his question' do
    sign_in users[0]
    visit question_path question

    within '.js-question' do
      expect(page).to_not have_link 'question-vote-up'
      expect(page).to_not have_link 'question-vote-down'
    end
  end
end
