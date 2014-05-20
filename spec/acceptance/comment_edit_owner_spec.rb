require_relative 'acceptance_helper'

feature 'Comment editing', %q(
  In order to fix mistakes
  As an author of Comment
  I want to be able to edit Comment
) do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }
  given!(:answer) { create(:answer, user: users[0], question: question) }
  given!(:comment1) { create(:comment, user: users[1], commentable: question) }
  given!(:comment2) { create(:comment, user: users[0], commentable: answer) }

  scenario 'Unauthenticated user try to edit comment' do
    visit question_path(question)
    save_and_open_page
    within '.js-question-comments.comments' do
      expect(page).to_not have_link 'Редактировать'
    end
    within '.js-answer-comments.comments' do
      expect(page).to_not have_link 'Редактировать'
    end
  end
end