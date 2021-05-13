class ReviewsController < ApplicationController
  before_action :find_user

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(reviews_params)
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

  def find_user
    @user = User.find(params[:user_id])
  end
end
