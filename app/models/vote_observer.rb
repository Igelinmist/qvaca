class VoteObserver < ActiveRecord::Observer
  def after_save(vote)
    user = vote.votable.user
    user.profile.rating = Vote.vote_rate(user) + user.answers_rating
    user.save!
    vote.votable.update_votes_stat if vote.votable_type = 'Question'
  end
end
