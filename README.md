# Swap Money Application: XWAPM

This support registered users to withdraw, deposit and transfer money from/to wallet.
Each user will have three defined wallet: UserWallet, TeamWallet & StockWallet

Demo: https://cryptic-temple-53050.herokuapp.com/

## Tech stacks
 - Rails 6.1.3.2 (https://rubyonrails.org/)
 - [Bootstrap](https://getbootstrap.com/) for styling and responsiveness
 - [PostgreSql](https://www.postgresql.org/) for database

## Features
 - Deposit money
 - Send/Transfer money
 - Withdraw money
 - Wallet’s balance & Transaction balance
 - Display transaction history for their wallets

## Architecture

- SwapM is structured based on MVC from the latest Rails
- An user has in three roles (user, team, stock) and corresponding wallet: User Wallet, Team Wallet & Stock Wallet
- A user has three default wallets


Models: Follows the STI pattern
  - Users: ```app/models/user.rb```  - Related info, generated using devise gem with manual customized views
  - Wallets: ```app/models/wallet.rb``` - Representative of user's wallets
  - Wallet_Details: ```app/models/wallet.rb``` - applies STI pattern to transform wallet into 3 types: User, Team, Stock
  - Transactions: ```app/models/transaction.rb``` - details of an transaction like: Deposit, Transfer & Withdraw


## Setup

Clone the repository or download a zip file

```
git clone https://github.com/TonChu/swapm.git
```
You have two option to run the app:
- Deploy to heroku app, all you need to do is to register a heroku app and follow this guide:
https://devcenter.heroku.com/articles/getting-started-with-rails6
- Install & Run it at your locals as following:

Install dependencies

```
bundle install
```

Setup database connection string for postgresql

```
config/database.yml
```
Create & Migrate database

```
rake db:create
rake db:migrate
```


Run the application
```
rails s
```
http://localhost:3000

Sign up/log in:

Please sign up to start using this SWAPM app

## Application Status
It is: `Draft` within a short time of development during free time of 2 days

## Things to be Enhanced
  - UI should be more user friendly
  - Form should use simple-form gem https://github.com/heartcombo/simple_form
  - Money for wallet should be handled with RubyMoney - Money-Rails https://github.com/RubyMoney/money-rails
  - Should writing unit test to enhance code quality
  - Error handling should be more strictly