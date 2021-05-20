class RemoveUsertypeFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :user_type
  end
end
