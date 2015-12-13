class Order < ActiveRecord::Base
  belongs_to :customer

  has_many :order_items

  validates :customer_id, presence: true
  validates :status, inclusion: { in: %w(pending processed cancelled) }
end
