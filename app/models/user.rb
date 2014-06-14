class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes, dependent: :destroy
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile
  delegate :display_name, to: :profile
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def points_for_answer
    self.answers.count
  end

  def points_for_first_answer
    self.answers.sum :the_first
  end

  def points_for_answer_own_question
    self.answers.sum :self_answer
  end

  def answers_rating
    points_for_answer + points_for_first_answer + points_for_answer_own_question
  end

end
