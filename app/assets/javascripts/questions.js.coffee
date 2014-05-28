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
    if $("#js-comment-#{comment.id}").length
      $("#js-comment-#{comment.id}").replaceWith($($.tmpl("comment", { id: comment.id, body: comment.body })))
    else
      $.tmpl("comment", { id: comment.id, body: comment.body }).appendTo('.js-question .comments')
      $('.new-comment-form').html('')
    $('.actions').show()
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.comment-errors').append(value)