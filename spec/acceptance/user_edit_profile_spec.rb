require_relative 'acceptance_helper'
feature 'User edit his profile', %q(
  In order to correct information about me
  As an authenticated User
  I want to be able edit my profile data
) do
  given!(:user) { create :user }

  scenario 'Guest not see link to edit profile' do
    visit questions_path

    expect(page).to_not have_link 'Профиль', href: edit_user_registration_path
  end

  context 'User sign in' do
    before { sign_in user }

    scenario 'edit profile data' do
      visit questions_path
      click_on 'Профиль'
      fill_in 'Псевдодим', with: 'my_nick'
      fill_in 'Текущий пароль', with: user.password
      click_on 'Сохранить User'

      expect(page).to have_content 'my_nick'
    end

  end
end