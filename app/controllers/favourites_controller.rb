class FavouritesController < ApplicationController
  before_action :find_listing, except: :destroy

  def new
  end

  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.listing = @listing
    if @favourite.save
      if URI(request.referer).path == '/listings'
        redirect_to listings_path(anchor: "card-#{@listing.id}")
      elsif URI(request.referer).path == '/'
        redirect_to root_path(anchor: "card-#{@listing.id}")
      elsif URI(request.referer).path == "/user/#{@favourite.user.id}"
        redirect_to user_path(@favourite.user, anchor: "card-#{@listing.id}")
      else
        redirect_to listing_path(@listing, anchor: "card-#{@listing.id}")
      end
    else
      flash.alert = "Unable to add to favourites"
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @listing = @favourite.listing
    @favourite.destroy
    redirect_to listings_path(anchor: "card-#{@listing.id}")
  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

  def find_page
    # if current_page?()
      
    # elsif
    # else
    # end
  end
end
