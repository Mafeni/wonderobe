class UsersController < ApplicationController
  before_action :find_user

  def show
    @favourite = Favourite.new
    @top_listings = Listing.most_hit(1.month.ago, 9)
    @reviews = Review.all.select  {|review| review.purchase.listing.user == @user}
    if @reviews.present?
      @sum_of_ratings = 0
      @reviews.each do |review|
        @sum_of_ratings += review.rating.to_i
      end
      @average_of_ratings = @sum_of_ratings / @reviews.count
      @rounded_average_of_ratings = @average_of_ratings.round
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :country, :photo)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
