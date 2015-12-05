class Customer < ActiveRecord::Base

  belongs_to :user, primary_key: 'id', foreign_key: 'id'

  has_many :orders
  has_many :review_ratings
  has_many :reviews

  validates :id, presence: true

end