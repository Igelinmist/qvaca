require_relative 'acceptance_helper'

feature 'User can delete his comment', %q(
  In order to remove my wrong remark
  As an authenticated user
  I want to be able delete my comment
) do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }
  given!(:answer) { create(:answer, user: users[1], question: question) }
  given!(:comment1) { create(:comment, user: users[0], commentable: question) }
  given!(:comment2) { create(:comment, user: users[0], commentable: answer) }

  scenario "guest can't delete comment" do
    visit question_path question

    within ".js-question .comments" do
      expect(page).to_not have_link 'Удалить'
    end

    within "#js-answer-#{answer.id} .comments" do
      expect(page).to_not have_link 'Удалить'
    end
  end

  context 'other user sign_in' do
    scenario 'not see link to delete comments' do
      sign_in users[1]
      visit question_path question

      within ".js-question .comments" do
        expect(page).to_not have_link 'Удалить'
      end

      within "#js-answer-#{answer.id} .comments" do
        expect(page).to_not have_link 'Удалить'
      end
    end
  end
  context 'author sign in' do
    before :each do
      sign_in users[0]
      visit question_path question
    end

    scenario 'delete own comment for question', js: true do
      within "#js-comment-#{comment1.id}" do
        click_on 'Удалить'
      end

      expect(page).to_not have_selector("#js-comment-#{comment1.id}")
    end

    scenario 'delete his comment', js: true do
      within "#js-comment-#{comment2.id}" do
        click_on 'Удалить'
      end

      expect(page).to_not have_selector("#js-comment-#{comment2.id}")
    end


  end



end