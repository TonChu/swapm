class Wallet < ApplicationRecord
  belongs_to :user
  has_many :wallet_details
  validates :title, presence: true, length: { minimum: 3 }
  delegate :user_wallets, :team_wallets, :stock_wallets, to: :wallet_details

end
