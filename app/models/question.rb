class Question < ActiveRecord::Base
  validates :title, length: {minimum: 15}
  validates :title, presence: true
  validates :body, presence: true
	has_many :answers
  has_many :comments, as: :commentable
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :answers
end
