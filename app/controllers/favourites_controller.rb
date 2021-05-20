class FavouritesController < ApplicationController
  before_action :find_listing, except: :destroy

  def new
  end

  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.listing = @listing
    if @favourite.save
      redirect_to request.referrer
    else
      flash.alert = "Unable to save transaction."
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_to request.referrer
  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end
end
