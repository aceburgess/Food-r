class Group < ActiveRecord::Base
  has_many :events
  has_many :group_users, source: :user
  has_many :admin, through: :group_users, source: :user
end
