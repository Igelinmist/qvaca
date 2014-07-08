class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes, dependent: :destroy

  has_many :authorizations, dependent: :destroy
  accepts_nested_attributes_for :authorizations

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  default_scope { order :created_at }

  def display_name() profile.display_name end

  def display_name=(name) profile.display_name = name end

  def real_name() profile.real_name end

  def real_name=(name) profile.real_name = name end

  def avatar() profile.avatar end

  def avatar=(name) profile.avatar = name end

  def points_for_answer() answers.count end

  def points_for_first_answer() answers.sum :the_first end

  def points_for_answer_own_question() answers.sum :self_answer end

  def points_for_best_answer() answers.sum :best_graid end

  def answers_rating() points_for_answer + points_for_first_answer + points_for_answer_own_question + points_for_best_answer end

  def self.find_for_oauth(auth)
    if authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
      authorization.user
    else
      if email = auth.info[:email]
        if user = User.where(email: email).first
          user.authorizations.create!(auth.slice(:provider, :uid))
        else
          password = Devise.friendly_token[0, 20]
          user = User.create!(email: email, password: password, password_confirmation: password)
          user.authorizations.build(auth.slice(:provider, :uid))
          user.build_profile
        end
      else
        user = User.create
      end
      user
    end
  end

  def self.new_with_session(params, session)
    if oauth = session["devise.oauth_attributes"]
      if params && params[:email]
        user = User.find_or_create_by(email: params[:email])
      else
        user = User.create
      end
      user.profile ||= user.build_profile
      user.authorizations.build(provider: oauth['provider'], uid: oauth['uid'].to_s)
      user.attributes = params
      user
    else
      super
    end
  end
end
