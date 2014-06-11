require_relative 'acceptance_helper'

feature 'View profiles', %q(
  In order to find out the experience of other user
  As a guest
  I want to be able to see the details of user's profile
) do
  given!(:user) { create :user }
  given!(:question) { create :question, user: user }
  given!(:answer) { create :answer, user: user, question: question }
  given!(:comment) { create :comment, user: user, commentable: question }

  context 'On question page' do
    before { visit question_path question }

    scenario 'Guest can view profile from questions list' do
      within '.js-question-author' do
        click_on 'Batman'
      end

      expect(page).to have_content 'Batman', 'Smith', 'www.night.com'
    end

    scenario "Guest can call profile for user's answer" do

      within "#js-answer-#{answer.id}" do
        click_on 'Batman'
      end

      expect(page).to have_content 'Batman', 'Smith', 'www.night.com'
    end

    scenario "Guest can call profile for user's comment" do
      within "#js-comment-#{comment.id}" do
        click_on 'Batman'
      end

      expect(page).to have_content 'Batman', 'Smith', 'www.night.com'
    end

    scenario "Return back after view profile" do
      within '.js-question-author' do
        click_on 'Batman'
      end
      click_on 'Назад'

      expect(current_path).to eq question_path question
    end
  end

end