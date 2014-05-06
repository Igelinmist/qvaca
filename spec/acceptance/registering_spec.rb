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
  
end