# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@bind_ajax_responce = (form_selector) ->
  $(form_selector).bind 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText)
    if $("#js-comment-#{comment.id}").length
      if comment.commentable_type is 'Question'
        $("#js-comment-#{comment.id}").replaceWith($.tmpl("comment", { commentable: 'questions', commentableId: comment.commentable_id, id: comment.id, body: comment.body }))
      else
        $("#js-comment-#{comment.id}").replaceWith($.tmpl("comment", { commentable: 'answers', commentableId: comment.commentable_id, id: comment.id, body: comment.body }))
    else
      if comment.commentable_type is 'Question'
        $.tmpl("comment", { commentable: 'questions', commentableId: comment.commentable_id, id: comment.id, body: comment.body }).appendTo('.js-question .comments')
      else
        $.tmpl("comment", { commentable: 'answers', commentableId: comment.commentable_id, id: comment.id, body: comment.body }).appendTo("#js-answer-#{comment.commentable_id} .comments")
      $('.new-comment-form').empty()

    $('.actions').show()
    $("form#new_answer").show()

  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.js-comment-errors').append(value)
