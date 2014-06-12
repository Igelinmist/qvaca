class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates_inclusion_of :voice, in: [-2, -1, 1, 2, 3]
end
