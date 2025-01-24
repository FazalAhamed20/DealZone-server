class Request < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :request_amount,presence: :true
end
