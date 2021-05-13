class ReviewsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @review = User.new(reviews_params)
    @user = User.find(params[:user_id])
    @review.user = @user
    if @review.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def reviews_params
    params.require(:review).permit(:rating, :content)
  end
end
