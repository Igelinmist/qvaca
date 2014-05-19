require_relative 'acceptance_helper'

feature 'User can comment question', %q{ 
  In order to leave note to question (not answer)
  As an authenticate user
  I want to comment the question
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario "user can call the form for question comment and save comment", js: true do
   sign_in(user)
   visit question_path question
   within '#js-question' do
     click_on 'Комментировать'
     fill_in 'comment_body', with: 'Мой комментарий'
     click_on 'Сохранить'
   end
   
   expect(current_path).to eq question_path question
   within '.js-question-comments' do
     expect(page).to have_content 'Мой комментарий'
   end
  end

  scenario "guest can't comment question" do
   visit question_path question

   within '#js-question' do
     expect(page).to_not have_link 'Комментировать'
   end
  end
end
 