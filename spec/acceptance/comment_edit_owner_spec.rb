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

    expect(find('.js-question')).to_not have_link 'Редактировать'
    expect(find('.answers')).to_not have_link 'Редактировать'
  end

  describe 'User0 sign in' do
    before do
      sign_in(users[0])
      visit question_path(question)
    end

    scenario "can't see comment link for question" do
      expect(find('.js-question').find('.comments'))
        .to_not have_link 'Редактировать'
    end

    scenario 'edit comment' do
      find('.answers').find('.comments').click_on('Редактировать')
      fill_in 'comment_body', with: 'Исправленный комментарий'
      click_on 'Сохранить'

      expect(find('.answers')).find('.comments')
        .to have_content 'Исправленный комментарий'
    end

    scenario "can't clear comment and save" do
      find('.answers').find('.comments').click_on('Редактировать')
      fill_in 'comment_body', with: ''
      click_on 'Сохранить'

      expect(page).to have_content 'Содержание не может быть пустым'
    end

    scenario 'can cancel edit comment' do
      find('.answers').find('.comments').click_on('Редактировать')
      fill_in 'comment_body', with: 'Исправленный комментарий'
      click_on 'Отмена'

      expect(page).to_not have_content 'Исправленный комментарий'
    end
  end

  describe 'User1 sign in' do
    before do
      sign_in(users[1])
      visit question_path(question)
    end

    scenario "can't see comment link for answers" do
      expect(find('.answers').find('.comments'))
        .to_not have_link 'Редактировать'
    end

    scenario 'edit comment' do
      find('.js-question').find('.comments').click_on('Редактировать')
      fill_in 'comment_body', with: 'Исправленный комментарий'
      click_on 'Сохранить'

      expect(find('.js-question')).find('.comments')
        .to have_content 'Исправленный комментарий'
    end

    scenario "can't clear comment and save" do
      find('.js-question').find('.comments').click_on('Редактировать')
      fill_in 'comment_body', with: ''
      click_on 'Сохранить'

      expect(page).to have_content 'Содержание не может быть пустым'
    end

    scenario 'can cancel edit comment' do
      find('.js-question').find('.comments').click_on('Редактировать')
      fill_in 'comment_body', with: 'Исправленный комментарий'
      click_on 'Отмена'

      expect(page).to_not have_content 'Исправленный комментарий'
    end
  end
end
