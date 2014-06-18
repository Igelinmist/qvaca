require_relative 'acceptance_helper'

feature 'Signing in', %q(
  In order to be able ask question
  As an user
  I want be able to sign in
) do
  
  given(:user) { create(:user) }

  scenario "Existing user try to sign in" do
    sign_in(user)

    expect(page).to have_content 'Вход в систему выполнен'
  end

  scenario 'Non-existing user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Пароль', with: '12345'
    within 'form' do
      click_on 'Вход'
    end

    expect(page).to have_content 'Неверный пароль или email'
  end

  scenario 'Non authenticate user see link Sign in' do
    visit '/'
    expect(page).to have_link 'Вход', new_user_session_path
  end

  scenario 'User sign in and not see Sign in link' do
    sign_in(user)
    visit '/'
    expect(page).to_not have_link 'Вход', new_user_session_path
  end

end