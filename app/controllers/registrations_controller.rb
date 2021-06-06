class RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up(_resource_name, user)
    super
    # do your stuff here
    @user = user
    @wallet = @user.wallets.create(:title => "#{@user.email}'s wallet", :description => "This is the defined wallet when register new user")
    @wallet.user_wallets.create(:balance => 0)
    @wallet.team_wallets.create(:balance => 0)
    @wallet.stock_wallets.create(:balance => 0)
  end

end
