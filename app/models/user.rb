class User < ActiveRecord::Base

  has_many :customers, primary_key: 'id', foreign_key: "id", dependent: :delete_all 
  has_many :store_managers, primary_key: 'id', foreign_key: "id", dependent: :delete_all 


  before_save { self.login_id = login_id.downcase }

  validates :login_id, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true
end
