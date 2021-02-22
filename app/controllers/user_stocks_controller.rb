class UserStocksController < ApplicationController
  def create
    stock = Stock.db_lookup(params[:stock])
    if stock.blank?
      stock = Stock.new_lookup(params[:stock])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = 'Added Successfully' 
    redirect_to my_portfolio_path
  end
  
  def destroy
    stock = Stock.find(params[:id])
    UserStock.where(user: current_user, stock: stock).first.destroy
    redirect_to my_portfolio_path
  end
end
