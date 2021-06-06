Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }

  get 'wallets/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "wallets#index"
end
