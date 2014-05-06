require 'spec_helper'

feature 'View question list', %q{
  In order to view questions
  As a non authenticate user
  I want to see the list of questions
  } do

  let!(:questions) { create_list(:question, 2) }

  scenario "Anyone is able to view the list of question" do
    visit questions_path
    # save_and_open_page
    # expect(page).to have_content(questions[0].title)
    expect(page).to have_content(questions[1].title)
  end

  scenario "The titles of questions are hyperlinks" do
    visit questions_path
    # save_and_open_page
    # expect(page).to have_link(questions[0].title)
    expect(page).to have_link(questions[1].title)
  end
end