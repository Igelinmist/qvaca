class Answer < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  accepts_nested_attributes_for :attachments

  def self.user_voted?(user)
    Votes.exists? user: user, votable: self
  end

  def self.put_like(user)
    vote = self.votes.build(user: user, voice: 1)
    vote.save!
  end

  def self.put_dislike(user)
    vote = self.votes.build(user: user, voice: -1)
    vote.save!
  end
end
