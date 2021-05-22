class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_listing, only: [:show, :update, :edit, :destroy]

  def index
    @top_listings = Listing.where(purchased_status: false).most_hit(1.month.ago, 9)
    if params[:query].present?
      @listings = Listing.where(purchased_status: false).search_by_listing_name_and_description(params[:query])
    else
      @listings = Listing.all.where(purchased_status: false)
    end
    @favourite = Favourite.new
    @users = User.where.not(latitude: nil, longitude: nil)
    @markers = @users.geocoded.map do |user|
      { lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
        currentUser: user == current_user
      }
    end
  end

  def show
    @favourite = Favourite.new
    @listing.punch(request)
    @top_listings = Listing.where(purchased_status: false).most_hit(1.month.ago, 9)
    @reviews = Review.all.select { |review| review.purchase.listing.user == @listing.user }
    @transaction = Purchase.new
    if @reviews.present?
      @sum_of_ratings = 0
      @reviews.each do |review|
        @sum_of_ratings += review.rating.to_i
      end
      @average_of_ratings = @sum_of_ratings / @reviews.count
      @rounded_average_of_ratings = @average_of_ratings.round
    end
  end

  def new
    @listing = Listing.new
    @conditions = ["New", "Almost New", "Used"]
    @sizes = ["XS", "S", "M", "L", "XL"]
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @listing.update(listing_params)
    redirect_to listing_path(@listing)
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:listing_name, :price, :size, :condition, :description, photos: [])
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end
end
