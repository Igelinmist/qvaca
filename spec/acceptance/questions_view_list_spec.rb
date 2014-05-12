require 'spec_helper'

feature 'View question list', %q{
In order to view questions
As a non authenticate user
I want to see the list of questions
} do

  given!(:questions) { create_list(:question, 2) }

  scenario "Anyone is able to view the list of question and the titles of questions are hyperlinks" do
    visit questions_path
    expect(page).to have_link questions[1].title, href: "/questions/#{questions[1].id}"
  end
end