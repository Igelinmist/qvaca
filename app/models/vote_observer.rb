class VoteObserver < ActiveRecord::Observer
  def after_save(vote)
    user = vote.votable.user
    user.profile.rating = Vote.vote_rate(user) + user.answers_rating
    user.save!
  end
end
