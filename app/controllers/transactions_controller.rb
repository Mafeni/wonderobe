class TransactionsController < ApplicationController
  before_action :find_listing
  def new
  end

  def create
    @transaction = Transaction.new()
    @transaction.user = current_user
    @transaction.listing = @listing
    if @transaction.save
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
