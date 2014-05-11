class Answer < ActiveRecord::Base
	validates :body, presence: true
  belongs_to :question
  has_many :comments, as: :commentable
end
