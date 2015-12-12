class Order < ActiveRecord::Base

  belongs_to :customer
  
  has_many :order_items

  validates :customer_id, presence: true
  validates :status, inclusion: { in: ["pending", "processed", "cancelled"] }

end