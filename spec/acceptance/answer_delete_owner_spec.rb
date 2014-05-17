require_relative 'acceptance_helper'

feature 'Owner delete answer', %q{ 
  In order to clear topic from bad or duplicate answer
  As an author of answer
  I want be able to delete answer
 } do
   given!(:users){ create_pair(:user) }
   given!(:question){ create(:question) }

   scenario 'Authenticated user create answer for question, see it in list and can delete it' do
     sign_in(users[0])
     visit question_path(question)
     fill_in 'Ваш ответ', with: 'Some text'
     click_on 'Сохранить'
     # within "#answer-#{}"
     # expect()

   end
 end