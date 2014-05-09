require 'spec_helper'

feature 'Signing in', %q{
  In order to be able ask question
  As an user
  I want be able to sign in
} do
  scenario "Existing user try to sign in" do
    User.create!(email: 'user@test.com', password: '12345678')
    
    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Non-existing user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid email or password'
  end

end