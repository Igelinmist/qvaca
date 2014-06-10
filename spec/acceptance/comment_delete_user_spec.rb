require_relative 'acceptance_helper'

feature 'User can delete his comment', %q(
  In order to remove my wrong remark
  As an authenticated user
  I want to be able delete my comment
) do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }
  given!(:comment1) { create(:comment, user: users[0], commentable: question) }
  given!(:comment2) { create(:comment, user: users[1], commentable: question) }
  given!(:answer) { create(:answer, user: users[1], question: question) }
  given!(:comment3) { create(:comment, user: users[0], commentable: answer) }
  given!(:comment4) { create(:comment, user: users[1], commentable: answer) }

  scenario "guest can't delete comment" do
    visit question_path question

    within ".js-question .comments" do
      expect(page).to_not have_link 'Удалить'
    end
  end

  context 'author sign in' do
    before do
      sign_in users[0]
      visit question_path question
    end

    scenario 'not see link to delete for not his comment' do
      within "#js-comment-#{comment2.id}" do
        expect(page).to_not have_link 'Удалить'
      end
    end

    scenario 'delete his comment', js: true do
      within "#js-comment-#{comment1.id}" do
        click_link 'Удалить'
        expect(current_path).to eq question_path question
      end
    end


  end



end