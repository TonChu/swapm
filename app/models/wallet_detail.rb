class WalletDetail < ApplicationRecord
  belongs_to :wallet
  has_many :transactions

  self.inheritance_column = :role   #STI pattern using custom field name
  scope :user_wallets, -> {where(role:"UserWallet")}
  scope :team_wallets, -> {where(role:"TeamWallet")}
  scope :stock_wallets, -> {where(role:"StockWallet")}

  validates :balance, numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: 0,  only_integer: true }

  def self.roles
    %w(UserWallet TeamWallet StockWallet)
  end

end
