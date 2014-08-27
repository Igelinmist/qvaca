class AnswerObserver < ActiveRecord::Observer
  def after_update(answer)
    user = answer.user
    user.profile.rating = Vote.vote_rate(user) + user.answers_rating
    user.save!
  end

  def after_save(answer)
    answer.question.update_answers_stat
  end
end