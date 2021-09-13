class RelationshipsController < ApplicationController
  
  #フォローフォロー解除機能
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow([:user_id])
    redirect_to request.referer
  end
  
  
  #フォローフォロワーの一覧表示
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end
