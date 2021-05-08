class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reviews, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :transactions, dependent: :destroy
  # validates :first_name, :last_name, :email, :address, :country, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
