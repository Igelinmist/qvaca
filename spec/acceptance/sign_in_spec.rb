require 'spec_helper'

feature 'signing in', %q{
	In order to be able ask question
	As an user
	I want be able sign in
  } do 
  scenario "Existing user try to sign in" do
  	User.create!(email: 'user@test.com', password: '12345678')
  	visit '/sign_in'
  	fill_in 'Email', with: 'user@test.com'
  	fill_in 'Password', with: '12345678'
  	click_on 'Sign in'

  	expect(page).to have_content 'You successfully signed in'
  end

  
end