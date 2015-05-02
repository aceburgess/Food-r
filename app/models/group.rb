class Group < ActiveRecord::Base
  has_many :events
  has_many :group_users, class_name: 'GroupUsers'
  has_many :members, through: :group_users, source: :user
  belongs_to :admin, class_name: 'User'
  belongs_to :organizer, class_name: 'User'
end
