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

  def self.search(param)
    param.strip!
    result = (first_name_match(param) + last_name_match(param) + email_match(param)).uniq
    return nil unless result
    result
  end

  def self.first_name_match(param)
    matches("first_name",param)
  end

  def self.last_name_match(param)
    matches("last_name",param)
  end

  def self.email_match(param)
    matches("email",param)
  end

  def self.matches(field,param)
    where("#{field} like ?", "%#{param}%")
  end

  def is_current_user(users)
    users.reject { |user| user.id == self.id}
  end
end
