class ReviewRating < ActiveRecord::Base

  belongs_to :customer
  belongs_to :review

  validates :customer_id1, :book_id, :customer_id2, presence: true
  validates :rating, inclusion: { in: (0..2).to_a }

end