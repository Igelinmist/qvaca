require 'spec_helper'

feature 'User can comment question', %q{ 
  In order to leave note to question (not answer)
  As an authenticate user
  I want to comment the question
 } do
   given(:user) { create(:user) }
   given!(:question) { create(:question) }
   
   scenario 'user can call the form for question comment and save comment', js: true do
     sign_in(user)
     visit question_path question
     within '#question' do
       #click_on 'Добавить комментарий'
       fill_in 'comment_body', with: 'Мой комментарий'
       click_on 'Комментировать'
     end
     
     expect(current_path).to eq question_path question
     within '#question_comments' do
       expect(page).to have_content 'Мой комментарий'
     end
   end
 end