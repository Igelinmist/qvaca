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

  is_impressionable counter_cache: true, column_name: :unique_views, unique: :all

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

  def vote(user, rate)
    unless voted_by? user
      vote = self.votes.build(user: user, voice: rate*2)
      vote.save!
    end
  end

  def best_answer
    answers.the_best.first
  end

  def summary_votes
    votes.sum :voice
  end

end
