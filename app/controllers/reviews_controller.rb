class ReviewsController < ApplicationController
  before_action :find_purchase
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(reviews_params)
    @review.purchase = @purchase
    if @review.save
      redirect_to user_path(@review.purchase.listing.user)
    else
      render :new
    end
  end

  private

  def reviews_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_purchase
    @purchase = Purchase.find(params[:purchase_id])
  end
end
