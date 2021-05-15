class Listing < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  has_many_attached :photos
  validates :listing_name, :price, :size, :condition, :photos, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 2000, too_long: "%{count} characters is the maximum allowed" }
  validates :size, inclusion: { in: %w(XS S M L XL) }
  validates :condition, inclusion: { in: ["New", "Almost New", "Used"] }

  include PgSearch::Model
  pg_search_scope :search_by_listing_name_and_description,
    against: [:listing_name, :description],
    using: {
      tsearch: {prefix: true}
    }
end
