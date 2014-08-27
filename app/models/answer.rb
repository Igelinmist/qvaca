class Answer < ActiveRecord::Base
  validates :body, presence: true

  before_save :init_points

  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :votes

  default_scope { order(best_graid: :desc, created_at: :asc) }

  scope :the_best, -> { (where best_graid: 3) }

  def voted_by?(user)
    Vote.exists? user: user, votable: self
  end

  def vote(user, rate)
    unless voted_by? user
      vote = self.votes.build(user: user, voice: rate)
      vote.save!
    end
  end

  def summary_votes
    votes.sum :voice
  end

  def make_the_best
    self.best_graid = 3
    save!
  end

  protected

  def init_points
    check_the_first
    check_the_self_answer user
  end

  def check_the_first
    self.the_first = 1 if self.question.answers.count == 0
  end

  def check_the_self_answer(user_id)
    self.self_answer = 1 if self.question.user == self.user
  end

end
