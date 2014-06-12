require_relative 'acceptance_helper'

feature 'Show question', %q(
In order to view the content of question
As a non authenticate user
I want to see the title and body of question
) do
  given!(:user) { create :user }
  given!(:questions) { create_list(:question, 2, user: user) }

  scenario 'Anyone is able to open details of question' do
    visit questions_path
    click_on questions[1].title

    expect(page).to have_content questions[1].body
  end
end
