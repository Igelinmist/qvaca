class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      guest_abilities
    end
  end

  def admin_abilities
      can :manage, :all
  end

  def user_abilities(user)
    can :read, :all
    can :create, [Question, Answer, Comment]

    can :update, Question, user_id: user.id
    can :destroy, Question, user_id: user.id
    can :vote, Question
    cannot :vote, Question, user_id: user.id

    can :update, Answer, user_id: user.id
    can :destroy, Answer, user_id: user.id
    can :vote, Answer
    cannot :vote, Answer, user_id: user.id
    can :mark_the_best, Answer, { question: { user_id: user.id } }

    can :update, Comment, user_id: user.id
    can :destroy, Comment, user_id: user.id
  end

  def guest_abilities
    can :read, [Question, Answer, Comment]
  end
end
