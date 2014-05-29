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

    scenario 'User (not author) give like to question' do
      visit question_path question
      within '.js-question' do
        click_on 'Нравится'
        expect(page).to_not have_link 'Нравится'
      end
      expect(page).to have_content 'Ваш голос принят!'
    end

    scenario 'User (not author) give dislike to question' do
      visit question_path question
      within '.js-question' do
        click_on 'Не нравится'
        expect(page).to_not have_link 'Нравится'
      end
      expect(page).to have_content 'Ваш голос принят!'
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
