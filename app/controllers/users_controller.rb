class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.is_current_user(@friends)
      if !@friends.empty?
        respond_to do |format|
          format.js { render partial: 'friends/result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "User Doesn't Exist"
          format.js { render partial: 'friends/result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Search box is Empty"
        format.js { render partial: 'friends/result'}
      end
    end
  end

  def profile
    @user = User.find(params[:format])
  end
end
