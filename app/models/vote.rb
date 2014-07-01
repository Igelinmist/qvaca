class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  belongs_to :question, -> { where(votes: { votable_type: 'Question' }) }, foreign_key: 'votable_id'
  belongs_to :answer, -> { where(votes: { votable_type: 'Answer' }) }, foreign_key: 'votable_id'

  validates_inclusion_of :voice, in: [-2, -1, 1, 2, 3]

  def self.questions_vote_rate(user)
    Vote.includes(:question).where(questions: { user_id: user.id }).sum(:voice)
  end

  def self.answers_vote_rate(user)
    Vote.includes(:answer).where(answers: { user_id: user.id }).sum(:voice)
  end

  def self.vote_rate(user)
    questions_vote_rate(user) + answers_vote_rate(user)
  end

end
