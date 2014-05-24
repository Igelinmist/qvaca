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

  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :attachments, allow_destroy: true

  def tag_names
    @tag_names || tags.pluck(:name).join(' ')
  end

  def save_tag_names
    if @tag_names
      self.tags = @tag_names.split.map { |name| Tag.where(name: name).first_or_create! }
    end
  end
end
