class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates_inclusion_of :voice, in: [-1, 1, 3]
end
