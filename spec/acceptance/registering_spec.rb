require 'spec_helper'

feature 'registering', %q{
  In order to become a member
  As a guest
  I want be able to register new user
} do 
  scenario "Guest visit any page and see invitation to register" do
    visit '/'
    expect(page).to have_link('Register')
  end

  scenario "Guest click Register link and view register form" do
    visit '/'
    click_on 'Register'
    # save_and_open_page
    expect(page).to have_content 'Please fill registration data'
  end

  scenario "Guest open register form and not see Register link" do
    visit new_user_path
    expect(page).to have_no_link 'Register'
  end
  
end