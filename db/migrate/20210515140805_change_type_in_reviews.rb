class ChangeTypeInReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :type
    add_column :reviews, :user_type, :string
  end
end
