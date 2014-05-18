require_relative 'acceptance_helper'

feature 'Question deleting', %q{
  In order to not show bad or dobled question
  As an author of Question
  I want to be able to delete Question
} do
  given!(:users) { create_pair(:user) }
  given!(:question) { create(:question, user: users[0]) }

  scenario "User who isn't an author of question not see link on delete" do
    sign_in(users[1])
    visit question_path question
    within '#js-question' do 
      expect(page).to_not have_link 'Удалить'
    end
  end

  scenario "Guest not see link on delete" do
    visit question_path question
    within '#js-question' do
      expect(page).to_not have_link 'Удалить'
    end
  end


  scenario "try delete question" do
    question_text = question.body
    sign_in(users[0])
    visit question_path(question)
    within '#js-question' do
      click_on 'Удалить'
    end

    expect(page).to_not have_content question_text
  end
end