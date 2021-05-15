class RenameTransactionsToPurchasesModel < ActiveRecord::Migration[6.0]
  def change
    rename_table :transactions, :purchases
  end
end
