class Event < ActiveRecord::Base
  belongs_to :group
  has_many :votes
  has_many :restaurants, through: :votes

  def check_winner
    (self.votes.count - self.restaurants.uniq.count) >= (self.group.members.count - 1 )
  end

  def winning_id
    self.votes.group_by {|vote| vote.restaurant_id}.sort {|k, v| k[1].count <=> v[1].count}.last.first
  end
end
