class Listing < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates :listing_name, :price, :size, :condition, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 2000, too_long: "%{count} characters is the maximum allowed" }
end
