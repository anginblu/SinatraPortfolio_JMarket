class User < ActiveRecord::Base
  has_many :stores
  has_many :products, through: :stores
  
  has_secure_password
  validates_presence_of :username, :email, :password
end
