require 'spec_helper'

feature 'Answering',%q{
  In order to share my knowledge
  As an authenticate user
  I want to public an answer
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticate user public an answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Ваш ответ', with: 'Some text'
    click_on 'Сохранить'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'Some text'
    end
  end

end