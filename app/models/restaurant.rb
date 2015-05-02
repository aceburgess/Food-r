class Restaurant < ActiveRecord::Base
  has_many :votes
  has_many :events, through: :votes
  has_many :organizers, through: :votes, source: :user
end
