require 'spec_helper'

feature 'registering', %q{
In order to become a member
As a guest
I want be able to register new user
} do 

  let(:user) {create(:user)}

  scenario "Guest visit any page and see invitation to register" do
    visit '/'
    expect(page).to have_link('Register')
  end

  scenario "Guest click Register link and view register form" do
    visit '/'
    click_on 'Register'
    # save_and_open_page
    expect(current_path).to eq(new_user_path)
  end

  scenario "Guest can fill the register form fields and apply form checking" do    
    visit new_user_path
    fill_in('Nickname', with: 'test_nick')
    fill_in('First Name', with: 'test_fname')
    fill_in('Last Name', with: 'test_lname')
    fill_in('Email', with: 'test@testsrv.com')    
    click_on('Save')
    expect(page).to have_content('You successfully registered')
  end

  scenario "Guest must fill Nickname field" do
    visit new_user_path
    fill_in('Nickname', with: nil)
    fill_in('First Name', with: user.first_name)
    fill_in('Last Name', with: user.last_name)
    fill_in('Email', with: user.email)       
    click_button('Save')
    expect(page).to have_content('error')
  end

  scenario "Guest must fill First Name field" do
    visit new_user_path
    fill_in('Nickname', with: user.nickname)
    fill_in('First Name', with: nil)
    fill_in('Last Name', with: user.last_name)
    fill_in('Email', with: user.email)    
    click_on('Save')
    expect(page).to have_content('error')
  end

  scenario "Guest must fill Last Name field" do 
    visit new_user_path
    fill_in('Nickname', with: user.nickname)
    fill_in('First Name', with: user.first_name)
    fill_in('Last Name', with: nil)
    fill_in('Email', with: user.email)    
    click_on('Save')
    expect(page).to have_content('error')
  end

  scenario "Guest must fill Email field" do
    visit new_user_path
    fill_in('Nickname', with: user.nickname)
    fill_in('First Name', with: user.first_name)
    fill_in('Last Name', with: user.last_name)
    fill_in('Email', with: nil)    
    click_on('Save')
    expect(page).to have_content('error')
  end

  scenario "Guest open register form and not see Register link" do
    visit new_user_path
    expect(page).to_not have_link 'Register'
  end
  
end