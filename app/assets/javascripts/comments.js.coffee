@bind_ajax_responce = (form_selector) ->
  $(form_selector).bind 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText)
    if $("#js-comment-#{comment.id}").length
      if comment.commentable_type is 'Question'
        $("#js-comment-#{comment.id}").replaceWith($.tmpl("comment", { commentable: 'questions', commentableId: comment.commentable_id, id: comment.id, body: comment.body, profileId: comment.profile_id, authorNick: comment.author_nick }))
      else
        $("#js-comment-#{comment.id}").replaceWith($.tmpl("comment", { commentable: 'answers', commentableId: comment.commentable_id, id: comment.id, body: comment.body, profileId: comment.profile_id, authorNick: comment.author_nick }))
    else
      if comment.commentable_type is 'Question'
        $.tmpl("comment", { commentable: 'questions', commentableId: comment.commentable_id, id: comment.id, body: comment.body, profileId: comment.profile_id, authorNick: comment.author_nick }).appendTo('.js-question .comments')
      else
        $.tmpl("comment", { commentable: 'answers', commentableId: comment.commentable_id, id: comment.id, body: comment.body, profileId: comment.profile_id, authorNick: comment.author_nick }).appendTo("#js-answer-#{comment.commentable_id} .comments")
      bind_delete_responce('#js-comment-'+comment.id)
      $('.new-comment-form').empty()

    $('.actions').show()
    $("form#new_answer").show()

  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.js-comment-errors').append(value)

@bind_delete_responce = (comment_selector) ->
  $(comment_selector).bind 'ajax:success', (e, data, status, xhr) ->
    comment_id = $.parseJSON(xhr.responseText)
    $('#js-comment-'+comment_id).remove()

$ ->
  $('.comment').bind 'ajax:success', (e, data, status, xhr) ->
    comment_id = $.parseJSON(xhr.responseText)
    $('#js-comment-'+comment_id).remove()
