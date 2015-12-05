class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :book

  validates :book_id, presence: true
  validates :copies, prsenece: true

end