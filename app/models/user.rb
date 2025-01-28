class User < ApplicationRecord
  include Clearance::User

  has_many :products
  has_many :requests
  
end
