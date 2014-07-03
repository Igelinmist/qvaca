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

  scenario 'View the details of question increment counter of views' do
    visit questions_path
    click_on questions[1].title
    click_on 'К вопросам'

    expect(page.find("#question-summary-#{questions[1].id} .views.mini-counts")).to have_content '1'
    expect(page.find("#question-summary-#{questions[0].id} .views.mini-counts")).to have_content '0'
  end

  scenario 'View the details of question increment counter of views only one time per session' do
    visit questions_path
    click_on questions[1].title
    click_on 'К вопросам'
    click_on questions[1].title
    click_on 'К вопросам'

    expect(page.find("#question-summary-#{questions[1].id} .views.mini-counts")).to have_content '1'
    expect(page.find("#question-summary-#{questions[0].id} .views.mini-counts")).to have_content '0'
  end
end
