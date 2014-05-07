class User < ActiveRecord::Base
  # validates :nickname, presence: true, unic
  validates :nickname, presence: true, uniqueness: true
end
