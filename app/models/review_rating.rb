class ReviewRating < ActiveRecord::Base

  belongs_to :customer
  belongs_to :review

end