require_relative 'acceptance_helper'

feature 'Sign in with twitter', %(
  In order to work in site
  As an authenticate user
  I want to be able sign in with twitter account
) do
  context 'new user' do
    scenario 'sign in by twitter to ask a quesion ' do
      mock_auth_hash
      visit '/'
      click_on 'Разместить вопрос'
      click_on 'Sign in with Twitter'
      fill_in '* Email', with: 'test@mock.com'
      fill_in '* Пароль', with: '12345678'
      fill_in '* Подтверджение пароля', with: '12345678'
      click_on 'Создать User'

      expect(page).to have_content 'В течение нескольких минут вы получите письмо с инструкциями'
    end
  end
end
