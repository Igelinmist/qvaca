class Answer < ActiveRecord::Base
	validates :body, presence: true
  validates :user_id, presence: true
  
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
end
