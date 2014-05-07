class User < ActiveRecord::Base
  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
