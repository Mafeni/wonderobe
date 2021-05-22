class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @top_listings = Listing.where(purchased_status: false).most_hit(1.month.ago, 9)
    @listings = Listing.all.where(purchased_status: false).sample(9)
    @favourite = Favourite.new
  end
end
