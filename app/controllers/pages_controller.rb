class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @top_listings = Listing.most_hit(1.month.ago, 9)
  end
end
