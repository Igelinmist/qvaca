class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes, dependent: :destroy

  has_many :authorizations, dependent: :destroy
  accepts_nested_attributes_for :authorizations

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  def display_name=(name)
    profile.display_name = name
  end

  def display_name
    profile.display_name
  end

  def points_for_answer
    answers.count
  end

  def points_for_first_answer
    answers.sum :the_first
  end

  def points_for_answer_own_question
    answers.sum :self_answer
  end

  def answers_rating
    points_for_answer + points_for_first_answer + points_for_answer_own_question
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    if email = auth.info[:email]
      if user = User.where(email: email).first
        user.authorizations.create!(auth.slice(:provider, :uid))
      else
        password = Devise.friendly_token[0, 20]
        user = User.create!(email: email, password: password, password_confirmation: password)
      end
    else
      user = User.create
    end
    user.authorizations.build(auth.slice(:provider, :uid))
    user.build_profile(
      display_name: auth.info['nickname'],
      real_name: auth.info['name'],
      location: auth.info['location'],
      avatar: auth.info['image'],
      about_me: auth.info['description'])
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.build_profile(session["devise.profile_attributes"])
        user.authorizations.build(session["devise.authorization_attributes"])
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

end
