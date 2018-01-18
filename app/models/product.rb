class Product < ActiveRecord::Base
  belongs_to :store

  validates_presence_of :name, :price, :store_id
end
