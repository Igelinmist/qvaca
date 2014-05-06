require 'spec_helper'

feature 'Show question', %q{
In order to view the content of question
As a non authenticate user
I want to see the title and body of question
} do
  let!(:questions) {create_list(:question, 2)}
  scenario "Anyone is able to open detail of question" do
    visit questions_path
    click_on questions[1].title
    expect(page).to have_content(questions[1].title)
  end

  scenario "Anyone is able to view content of question" do
    visit questions_path
    click_on questions[1].title
    expect(page).to have_content(questions[1].body)

  end
end
