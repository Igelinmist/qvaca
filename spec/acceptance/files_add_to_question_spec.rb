require_relative 'acceptance_helper'

feature 'Add files to question', %q(
  In order to explain the question
  As an author of question
  I want to be able to attach some files
) do
  given(:user) { create :user }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Заголовок', with: 'Test question 15'
    fill_in 'Содержание', with: 'test text'
    attach_file 'Файл', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Сохранить'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
