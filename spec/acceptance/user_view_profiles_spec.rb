require_relative 'acceptance_helper'

feature 'View profiles', %q(
  In order to find out the experience of other user
  As a guest
  I want to be able to see the details of user's profile
) do
  
  scenario 'Guest can view profile from questions list'
  scenario "Guest can call profile for user's answer"
  scenario "Guest can call profile for user's comment"

end