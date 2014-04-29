class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions
  validates_length_of :title, in: 5..30
end
