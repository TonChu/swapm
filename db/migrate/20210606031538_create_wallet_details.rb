class CreateWalletDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :wallet_details do |t|
      t.integer :balance
      t.string :role
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
