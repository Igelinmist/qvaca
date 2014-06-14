require_relative 'acceptance_helper'

feature 'Questioning mark the best answer', %q(
  In order show solution of problem
  As an author of question
  I want to be able select the best answer
) do
  given!(:users) { create_pair :user }
  given!(:question) { create :question, user: users[0] }
  given!(:answer1) { create :answer, question: question, user: users[1] }
  given!(:answer2) { create :answer, question: question, user: users[0] }

  scenario "User (not questioning) not see 'the best' button" do
    sign_in users[1]
    visit question_path question

    expect(find("#js-answer-#{answer1.id}")).to_not have_link("the-best-#{answer1.id}")
    expect(find("#js-answer-#{answer2.id}")).to_not have_link("the-best-#{answer2.id}")
  end

  describe "Author of question" do
    before do
      sign_in(users[0])
      visit question_path question
    end

    scenario "see button 'the best' with every answer" do
      expect(find("#js-answer-#{answer1.id}")).to have_link("the-best-#{answer1.id}")
      expect(find("#js-answer-#{answer2.id}")).to have_link("the-best-#{answer2.id}")
    end

    scenario "select the best answer" do
      click_link("the-best-#{answer2.id}")

      expect(current_path).to eq question_path question
      expect(find("#js-answer-#{answer1.id}")).to_not have_link("the-best-#{answer1.id}")
      expect(find("#js-answer-#{answer2.id}")).to_not have_link("the-best-#{answer2.id}")
      expect(page).to have_selector('#the-best-answer')

    end
  end

end