class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  accepts_nested_attributes_for :profile
  delegate :display_name, to: :profile
  

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

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization
    email = auth.info[:email]
    user = User.where(email: email).first
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
    end
    user.authorizations.create(provider: auth.provider, uid: auth.uid)
    user
  end

end
