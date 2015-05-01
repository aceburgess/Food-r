class User < ActiveRecord::Base
  has_many :group_users
  has_many :events, through: :groups
  has_many :groups, through: :group_users
  has_many :votes
end
