require_relative 'acceptance_helper'

feature 'Comment deleting', %q(
  In order to hide stupidity
  As an author of Comment
  I want to be able to delete Comment
) do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }
  given!(:answer) { create(:answer, question: question, user: users[1]) }
  given!(:comment1) { create(:comment, user: users[1], commentable: question) }
  given!(:comment2) { create(:comment, user: users[0], commentable: answer) }

  scenario 'Unauthenticated user try to delete comment' do
    visit question_path(question)

    expect(find('.js-question .comments')).to_not have_link 'Удалить'
    expect(find('.js-answers .comments')).to_not have_link 'Удалить'
  end

  scenario "User0 can delete answer comment, not question comment" do
    sign_in(users[0])
    visit question_path(question)
    expect(find('.js-answers .comments')).to have_link 'Удалить'
    expect(find('.js-question .comments')).to_not have_link 'Удалить'
  end

  scenario "User1 can delete question comment, not answer comment" do
    sign_in(users[1])
    visit question_path(question)
    expect(find('.js-answers .comments')).to_not have_link 'Удалить'
    expect(find('.js-question .comments')).to have_link 'Удалить'
  end

  describe 'User0 sign in' do
    before do
      sign_in(users[0])
      visit question_path(question)
    end


    scenario "see link Delete under answer's comment", js: true do
      within '.js-answers .comments' do
        click_on 'Удалить'
        
        expect(page).to_not have_content(comment2.body)
      end
    end
  end

  describe 'User1 sign in' do
    before do
      sign_in(users[1])
      visit question_path(question)
    end

    scenario 'see link Delete under question', js: true do
      within '.js-question .comments' do
        click_on 'Удалить'

        expect(page).to_not have_content(comment1.body)
      end
    end

  end
end
