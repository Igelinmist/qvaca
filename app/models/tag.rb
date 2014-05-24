class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :questions, through: :taggings
  validates :title, length: { in: 5..30 }
end
