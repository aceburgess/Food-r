class User < ActiveRecord::Base
  include BCrypt
  has_many :events, through: :groups
  has_many :groups, through: :group_users
  has_many :group_users, class_name: 'GroupUsers'
  has_many :votes

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(string_password)
    self.password == string_password
  end
end
