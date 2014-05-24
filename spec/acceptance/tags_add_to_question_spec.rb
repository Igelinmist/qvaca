require_relative 'acceptance_helper'

feature 'Add tags to question', %q(
  In order to improve search of answer
  As authenticate user
  I want to be able to add tags to question
) do
  given!(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
    fill_in 'Заголовок', with: 'Test question to check tags'
    fill_in 'Содержание', with: 'Some question'

  end

  scenario 'User create question and add  new tag' do
    fill_in 'Метки', with: 'Ruby Rails'
    click_on 'Сохранить'

    expect(find('.tags')).to have_content('Ruby, Rails')
  end
end
