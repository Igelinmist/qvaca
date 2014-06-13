module QuestionsHelper
  def can_vote(votable)
    user_signed_in? && votable.user != current_user && !votable.voted_by?(current_user)
  end
end
