class Book < ActiveRecord::Base

  has_many :orders
  has_many :reviews

  validates :isbn13, presence: true, length: {is: 14}

end