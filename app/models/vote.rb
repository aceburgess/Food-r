class Vote < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  belongs_to :event
end
