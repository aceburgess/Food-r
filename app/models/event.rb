class Event < ActiveRecord::Base
  belongs_to :group
  has_many :votes
  has_many :restaurants, through: :votes
end
