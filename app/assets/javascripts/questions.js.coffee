# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@cancelForm = () ->
  $('.actions').show()
  $('.edit-form').html('')
  $('.new-answer-form').html('')
  $('.new-comment-form').html('')

$ ->
  $(document).bind 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText)
    $('.js-question .comments').append('<p>' + comment.body + '</p>')
    $('.new-comment-form').html('')
    $('.actions').show()
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.comment-errors').append(value)