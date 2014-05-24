require_relative 'acceptance_helper'

feature 'Add files to question', %q(
  In order to explain the question
  As an author of question
  I want to be able to attach some files
) do
  given!(:user) { create :user }
  given!(:question) { create :question, user: user }

  background do
    sign_in(user)
  end

  scenario 'User adds file when asks question', js: true do
    visit new_question_path
    fill_in 'Заголовок', with: 'Test question 15'
    fill_in 'Содержание', with: 'test text'
    click_on 'Добавить файл'
    attach_file 'Файл', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Сохранить'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'User adds file when edit question', js: true do
    visit edit_question_path question
    click_on 'Добавить файл'
    attach_file 'Файл', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Сохранить'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
