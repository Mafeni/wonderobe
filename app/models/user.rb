class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reviews, through: :purchases
  has_many :listings, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_one_attached :photo
  # validates :first_name, :last_name, :email, :address, :country, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
