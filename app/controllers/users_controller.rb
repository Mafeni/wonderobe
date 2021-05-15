class UsersController < ApplicationController
  before_action :find_user

  def show
    if @user.reviews.present?
      @sum_of_ratings = 0
      @user.reviews.each do |review|
        @sum_of_ratings += review.rating.to_i
      end
      @average_of_ratings = @sum_of_ratings / @user.reviews.count
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
