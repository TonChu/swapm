class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :description
      t.string :transaction_type

      t.references :sender
      t.references :receiver

      t.timestamps
    end
  end
end
