class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_listing, only: [:show, :update, :edit, :destroy]

  def index
    @listings = Listing.all
  end

  def show
    @transaction = Transaction.new
  end

  def new
    @listing = Listing.new
    @conditions = ["New", "Almost new", "Used"]
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

  def edit; end

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
