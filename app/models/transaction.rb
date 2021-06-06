class Transaction < ApplicationRecord
  belongs_to :sender, class_name: "WalletDetail", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "WalletDetail", foreign_key: "receiver_id"

  validates :description, presence: true, length: { minimum: 10 }
  validates :transaction_type, presence: true, inclusion: { in: ["Transfer", "Deposit", "Transfer"] }
  validates :amount, presence: true, numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: 0,  only_integer: true }


end
