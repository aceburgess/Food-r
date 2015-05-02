class Group < ActiveRecord::Base
  has_many :events
  has_many :group_users, class_name: 'GroupUsers'
  has_many :members, through: :group_users, source: :user
  has_many :admin, through: :group_users, source: :user
end
