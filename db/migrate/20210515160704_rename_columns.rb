class RenameColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column      :reviews, :transaction_id, :purchase_id
    add_foreign_key    :reviews, :purchases
  end
end
