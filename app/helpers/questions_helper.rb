module QuestionsHelper
  def can_vote?(votable)
    # user_signed_in? && votable.user != current_user && !votable.voted_by?(current_user)
    can?(:vote, votable) && !votable.voted_by?(current_user)
  end

  def sign_in_author(question, user=current_user)
    user == question.user
  end
end
