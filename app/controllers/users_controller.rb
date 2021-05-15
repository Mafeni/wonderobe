class UsersController < ApplicationController
  before_action :find_user

  def show
    @reviews = Review.all.select  {|review| review.purchase.listing.user == @user}
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
