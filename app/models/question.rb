class Question < ActiveRecord::Base
	validates_length_of :title, minimum: 15
	validates_presence_of :title
	validates_presence_of :body
	has_many :answers
  has_many :comments, as: :commentable
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :answers
end
