class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :book

  validates :book_id, presence: true
  validates :copies, presence: true
  validates :order_id, presence: true

end