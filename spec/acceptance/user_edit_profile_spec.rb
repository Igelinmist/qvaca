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
      click_on 'Batman'
      fill_in 'Псевдоним', with: 'my_nick'
      click_on 'Сохранить Profile'

      within '.navbar' do
        expect(page.find('img')['alt']).to eq 'my_nick'
      end
      expect(page).to have_content 'Ваш профиль успешно обновлен.'
    end
  end
end
