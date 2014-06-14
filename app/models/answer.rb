class Answer < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :votes

  def voted_by?(user)
    Vote.exists? user: user, votable: self
  end

  def vote(user, rate)
    vote = self.votes.build(user: user, voice: rate)
    vote.save!
  end

  def summary_votes
    self.votes.sum :voice
  end

  def make_the_best
    self.best_graid = 3
    self.save!
  end

  scope :the_best, -> { where best_graid: 3}
end
