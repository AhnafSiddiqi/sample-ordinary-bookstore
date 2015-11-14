class Review < ActiveRecord::Base

  belongs_to :customer
  belongs_to :book

  has_many :review_ratings

end