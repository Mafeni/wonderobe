class Review < ApplicationRecord
  belongs_to :user
  validates :type, :rating, presence: true
  validates :comment, length: { maximum: 2000, too_long: "%{count} characters is the maximum allowed" }
end