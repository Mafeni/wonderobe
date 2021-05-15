class AddTransactionToReviews < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :user
    add_reference :reviews, :transaction, null: false, foreign_key: true
  end
end
