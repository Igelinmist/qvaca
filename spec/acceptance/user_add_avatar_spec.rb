require_relative 'acceptance_helper'
feature 'User add avatar', %q(
  In order to represent myself with a picture
  As an authenticated User
  I want to be able add my avatar
) do
  given!(:user) { create :user }

  context 'with valid image' do
    scenario 'upload new image file for avatar' do
      sign_in user
      visit '/'
      within '.navbar' do
        click_on 'Batman'
      end
      attach_file 'Аватар', "#{Rails.root}/spec/factories/default_user.jpeg"
      click_on 'Сохранить Profile'

      expect(page.find('.navbar img')['src']).to eq "/img/profile/avatar/#{user.profile.id}/thumb_default_user.jpeg"
    end
  end

  context 'with invalid image' do
    scenario 'upload new image file for avatar' do
      sign_in user
      visit '/'
      within '.navbar' do
        click_on 'Batman'
      end
      attach_file 'Аватар', "#{Rails.root}/spec/factories/test_bad.bmp"
      click_on 'Сохранить Profile'

      expect(page).to have_content 'Недопустимый формат'
    end
  end

end
