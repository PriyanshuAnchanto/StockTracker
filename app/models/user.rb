class User < ApplicationRecord
  has_many :user_stocks 
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def already_present?(ticker)
    stocks.where(ticker: ticker).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track?(ticker)
    under_stock_limit? && !already_present?(ticker)
  end
end
