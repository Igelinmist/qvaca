require_relative 'acceptance_helper'

feature 'Add files to answer', %q(
  In order to explain the answer
  As an answer's author
  I want to be able to attach some files
) do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'User adds file when makes an answer', js: true  do
    sign_in(user)
    visit question_path(question)
    click_on 'Ответить'
    fill_in 'Ответ', with: 'Мой новый ответ'
    click_on 'Добавить файл'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Сохранить'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
