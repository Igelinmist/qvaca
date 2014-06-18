module QuestionsHelper
  def can_vote?(votable)
    can?(:vote, votable) && !votable.voted_by?(current_user)
  end

  def sign_in_author?(question, user=current_user)
    user == question.user
  end
end
