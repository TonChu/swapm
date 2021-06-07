class WalletDetail < ApplicationRecord
  belongs_to :wallet
  has_many :transactions

  #Implement STI pattern
  self.inheritance_column = :role   #STI pattern using custom field name
  scope :user_wallets, -> {where(role:"UserWallet")}
  scope :team_wallets, -> {where(role:"TeamWallet")}
  scope :stock_wallets, -> {where(role:"StockWallet")}

  validates :balance, numericality: { less_than_or_equal_to: 10000000, greater_than_or_equal_to: 0,  only_integer: true }

  def self.roles
    %w(UserWallet TeamWallet StockWallet)
  end

  def wallet_name
    [self.wallet.title, self.role].join('- ')
  end

  def balance_from_transactions
    trans = Transaction.where("sender_id = ? or receiver_id = ?", self.id, self.id)
    balance_tmp = 0
    if (!trans.nil? && trans.length > 0)
      trans.each do |tran|
        if(tran.transaction_type == "Deposit")
          balance_tmp += tran.amount
        elsif (tran.transaction_type == "Withdraw")
          balance_tmp -= tran.amount
        elsif (tran.transaction_type == "Transfer")
          if(tran.sender_id == self.id)
            balance_tmp -= tran.amount
          end
          if(tran.receiver_id == self.id)
            balance_tmp += tran.amount
          end
        end
      end
    end
    balance_tmp
  end


end
