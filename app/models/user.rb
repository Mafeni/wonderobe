class User < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_create :set_country

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :listings, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :reviews, through: :purchases
  has_one_attached :photo
  # validates :first_name, :last_name, :email, :address, :country, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  private
  
  def set_country
    user_posn = Geocoder.search([self.latitude, self.longitude])
    self.country = user_posn[0].country_code
    self.save
  end
end
