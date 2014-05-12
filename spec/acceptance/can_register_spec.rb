require 'spec_helper'

feature 'Registration', %q{
  In order to work on site
  As a guest
  I want be able to register
} do
  scenario 'Guest open home page and use link Sign up' do
    visit '/'
    click_link 'Регистрация'

    expect(page).to have_content 'Введите данные для регистрации на сайте'
  end
end