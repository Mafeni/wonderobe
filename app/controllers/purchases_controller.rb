class PurchasesController < ApplicationController
  before_action :find_listing
  
  def new
  end

  def create
    @purchase = Purchase.new()
    @purchase.user = current_user
    @purchase.listing = @listing
    if @purchase.save
      redirect_to user_path(current_user)
    else
      flash.alert = "Unable to save transaction."
    end
  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end
end
