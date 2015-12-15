class StoreManager < ActiveRecord::Base
  belongs_to :user, primary_key: 'id', foreign_key: 'id'

  validates :id, presence: true
end
