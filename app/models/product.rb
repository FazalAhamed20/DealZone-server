class Product < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :category,presence: true
  validates :price, presence: true
  validates :image, presence: :true
end
