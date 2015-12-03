class User < ActiveRecord::Base

  has_many :customers
  has_many :store_managers


  before_save { self.login_id = login_id.downcase }

  validates :login_id, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true,
                       length: { minimum: 4 }
end
