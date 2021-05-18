class Review < ApplicationRecord
  belongs_to :purchase
  validates :rating, presence: true
  validates :user_id, uniqueness: { scope: :purchase_id }
  validates :comment, length: { maximum: 2000, too_long: "%{count} characters is the maximum allowed" }
end
