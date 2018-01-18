class Store < ActiveRecord::Base
  belongs_to :user
  has_many :products

  validates_presence_of :name
end
