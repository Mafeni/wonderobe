class PurchasesController < ApplicationController
  before_action :find_listing, :find_favourites

  def new
  end

  def create
    @purchase = Purchase.new
    @purchase.user = current_user
    @listing.purchased_status = true
    @listing.save!
    @purchase.listing = @listing
    if @purchase.save
      redirect_to user_path(current_user)
      @favourites.destroy_all
    else
      flash.alert = "Unable to save transaction."
    end
  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

  def find_favourites
    @favourites = Favourite.where(listing: @listing)
  end
end
