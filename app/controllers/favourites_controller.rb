class FavouritesController < ApplicationController
  def new
  end

  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.listing = @listing
    if @favourite.save
      redirect_to user_path(current_user)
    else
      flash.alert = "Unable to save transaction."
    end
  end

  def destroy

  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end
end
