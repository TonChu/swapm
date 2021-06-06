class User < ApplicationRecord
  has_many :wallets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_USER_TYPES = %w[user admin]
  validates :user_type, presence: true, inclusion: { in: VALID_USER_TYPES }
  validates :password, presence: true

end
