require 'spec_helper'

feature 'view question list', %q{
  In order to view questions
  As a non authenticate user
  I want to see the list of questions
  } do
  before {create_list(:question, 2)}
  scenario "Anyone is able to view the list of question" do
    visit questions_path
    #save_and_open_page
    expect(page).to have_content('MyStringFifteenMin')
  end
end