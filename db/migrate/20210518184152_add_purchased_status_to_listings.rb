class AddPurchasedStatusToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :purchased_status, :boolean, default: false
  end
end
