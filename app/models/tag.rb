class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions
  validates :title, length: {in: 5..30}
end
