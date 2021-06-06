class TransactionsController < ApplicationController
  def index
    @wallet = Wallet.find(params[:wallet_id]);
    case params[:role]
    when 'u'
      @transactions = @wallet.user_wallets;
    when 't'
      @transactions = @wallet.team_wallets;
    when 's'
      @transactions = @wallet.stock_wallets;
    else
      @transactions = @wallet.user_wallets;
    end
  end
end
