class StoreManager < ActiveRecord::Base

  belongs_to :user

  validates :login_id,  presence: true

end