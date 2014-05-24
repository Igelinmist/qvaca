class Question < ActiveRecord::Base
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
end
