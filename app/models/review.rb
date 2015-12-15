class Review < ActiveRecord::Base
  belongs_to :customer
  belongs_to :book

  has_many :review_ratings

  validates :customer_id, :book_id, :score, presence: true
  validates :score, inclusion: { in: (1..10).to_a }
end
