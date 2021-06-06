class WalletsController < ApplicationController
  def index
    @wallet = Wallet.where(user_id: current_user[:id]).first
  end
end
