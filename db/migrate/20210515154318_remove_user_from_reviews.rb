class RemoveUserFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :reviews, column: :user_id
  end
end
