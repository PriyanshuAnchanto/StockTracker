class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:format])
    Friendship.create(user:current_user, friend: friend)
    redirect_to my_friends_path
  end

  def destroy
    friend = User.find(params[:id])
    Friendship.where(user: current_user,friend: friend).first.destroy
    redirect_to my_friends_path
  end
end