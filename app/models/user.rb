class User < ActiveRecord::Base
  include BCrypt
  has_many :group_users
  has_many :events, through: :groups
  has_many :groups, through: :group_users
  has_many :votes

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(plaintext_password)
    self.password == plaintext_password
  end
end
