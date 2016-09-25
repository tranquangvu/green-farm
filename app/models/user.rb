class User < ApplicationRecord
  has_many :farms
  
  devise :database_authenticatable, :rememberable, :trackable, :validatable
end
