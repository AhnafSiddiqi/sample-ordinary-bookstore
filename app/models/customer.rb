class Customer < ActiveRecord::Base

  belongs_to :user

  has_many :orders
  has_many :review_ratings
  has_many :reviews

  validates :login_id, presence: true

end