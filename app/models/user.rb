class User < ActiveRecord::Base

  has_many :customers
  has_many :store_managers

end