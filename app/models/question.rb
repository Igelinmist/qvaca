class Question < ActiveRecord::Base

  attr_writer :tag_names

  before_save :save_tag_names

  validates :title, length: { minimum: 15 }
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :votes, as: :votable, dependent: :destroy

  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :attachments, allow_destroy: true
  has_many :votes, as: :votable, dependent: :destroy

  def tag_names
    @tag_names || tags.pluck(:name).join(' ')
  end

  def save_tag_names
    if @tag_names
      self.tags = @tag_names.split.map { |name| Tag.where(name: name).first_or_create! }
    end
  end

  def voted_by?(user)
    Vote.exists? user: user, votable: self
  end

  def vote_up(user)
    vote = self.votes.build(user: user, voice: 1)
    vote.save!
  end

  def vote_down(user)
    vote = self.votes.build(user: user, voice: -1)
    vote.save!
  end
end
