# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@cancelForm = () ->
  $('.actions').show()
  $('.edit-form').empty()
  $('.new-answer-form').empty()
  $('.new-comment-form').empty()

