class Restaurant < ActiveRecord::Base
  has_many :votes
  has_many :events, through: :votes
end
