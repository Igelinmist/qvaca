require_relative 'acceptance_helper'

feature 'Comment editing', %q(
  In order to fix mistakes
  As an author of Comment
  I want to be able to edit Comment
) do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:comment) { create(:comment, user: user, commentable: answer) }

  scenario 'Unauthenticated user try to edit comment' do
    visit question_path(question)

    expect(find('.js-answers-comments')).to_not have_link 'Редактировать'
  end

  describe 'User sign in' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'edit comment', js: true do
      find('.js-answers-comments').click_on('Редактировать')
      fill_in 'comment_body', with: 'Исправленный комментарий'
      click_on 'Сохранить'

      expect(find('.js-answers-comments'))
        .to have_content 'Исправленный комментарий'
    end

    scenario "can't clear comment and save", js: true do
      find('.js-answers-comments').click_on('Редактировать')
      fill_in 'comment_body', with: ''
      click_on 'Сохранить'

      expect(page).to have_content 'Содержание не может быть пустым'
    end

    scenario 'can cancel edit comment', js: true do
      find('.js-answers-comments').click_on('Редактировать')
      fill_in 'comment_body', with: 'Исправленный комментарий'
      click_on 'Отмена'

      expect(page).to_not have_content 'Исправленный комментарий'
    end
  end
end
