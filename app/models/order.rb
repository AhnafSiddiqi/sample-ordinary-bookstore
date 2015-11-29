class Order < ActiveRecord::Base

  belongs_to :customer
  belongs_to :book

  validates :customer_id, :book_id, presence: true
  validates :status, inclusion: { in: ["pending", "processed", "cancelled"] }

end