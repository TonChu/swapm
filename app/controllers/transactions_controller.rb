class TransactionsController < ApplicationController
  def index
    @wallet = Wallet.find(params[:wallet_id])
    @name = get_wallet_name params[:role]
    case params[:role]
    when 'u'
      @transactions = Transaction.where("(sender_id = ? or receiver_id = ?)", @wallet.user_wallets.first[:id], @wallet.user_wallets.first[:id])
    when 't'
      @transactions = Transaction.where("(sender_id = ? or receiver_id = ?)", @wallet.team_wallets.first[:id], @wallet.team_wallets.first[:id])
    when 's'
      @transactions = Transaction.where("(sender_id = ? or receiver_id = ?)", @wallet.stock_wallets.first[:id], @wallet.stock_wallets.first[:id])
    end
  end

  def new
    @wallet = Wallet.find(params[:wallet_id]);
    @name = get_wallet_name params[:role]
    @balance = get_wallet_balance(params[:role], @wallet)
    @transaction = Transaction.new
    @wallet_details = @wallet.wallet_details;
    case params[:tran_type]
    when 'deposit'
      @action = "Deposit"
    when 'withdraw'
      @action = "Withdraw"
    when 'transfer'
      @action = "Transfer"
    end
  end

  def create
    @wallet = Wallet.find(params[:wallet_id]);
    @name = get_wallet_name params[:transaction][:role]
    @wallet_detail = get_wallet_detail(params[:transaction][:role], @wallet)

    case params[:transaction][:tran_type]
    when 'deposit'
      @action = "Deposit"
      ActiveRecord::Base.transaction do
        @transaction = Transaction.new(:amount => params[:transaction][:amount],:description => params[:transaction][:description],:sender_id => @wallet_detail[:id],:receiver_id => @wallet_detail[:id], :transaction_type => @action)
        if @transaction.save
          @wallet_detail.update(:balance => @wallet_detail.balance + params[:transaction][:amount].to_i)
        end
      end

      redirect_to wallets_path
    when 'withdraw'
      @action = "Withdraw"
      ActiveRecord::Base.transaction do
        if(@wallet_detail.balance - params[:transaction][:amount].to_i >= 0)
          @transaction = Transaction.new(:amount => params[:transaction][:amount],:description => params[:transaction][:description],:sender_id => @wallet_detail[:id],:receiver_id => @wallet_detail[:id], :transaction_type => @action)
          if @transaction.save
            @wallet_detail.update(:balance => @wallet_detail.balance - params[:transaction][:amount].to_i)
          end
        end
      end

      redirect_to wallets_path
    when 'transfer'
      @action = "Transfer"
      ActiveRecord::Base.transaction do
        if(@wallet_detail.balance - params[:transaction][:amount].to_i >= 0)
          @transaction = Transaction.new(:amount => params[:transaction][:amount],:description => params[:transaction][:description],:sender_id => @wallet_detail[:id],:receiver_id => params[:transaction][:receiver_id], :transaction_type => @action)
          if @transaction.save
            @wallet_detail.update(:balance => @wallet_detail.balance - params[:transaction][:amount].to_i)
            @receiver_wallet_detail = WalletDetail.find(params[:transaction][:receiver_id])
            @receiver_wallet_detail.update(:balance => @receiver_wallet_detail.balance + params[:transaction][:amount].to_i)
          end
        end
      end

      redirect_to wallets_path
    end
  end

  private
  def get_wallet_name(short)
    if short == "u" then name = "User Wallet" end
    if short == "t" then name = "Team Wallet" end
    if short == "s" then name = "Stock Wallet" end
    name
  end
  def get_wallet_balance(short, wallet_to_get)
    if short == "u" then balance = wallet_to_get.user_wallets.first[:balance] end
    if short == "t" then balance = wallet_to_get.team_wallets.first[:balance] end
    if short == "s" then balance = wallet_to_get.stock_wallets.first[:balance] end
    balance
  end

  def get_wallet_detail(short, wallet_to_get)
    if short == "u" then wallet_detail = wallet_to_get.user_wallets.first end
    if short == "t" then wallet_detail = wallet_to_get.team_wallets.first end
    if short == "s" then wallet_detail = wallet_to_get.stock_wallets.first end
    wallet_detail
  end

end
