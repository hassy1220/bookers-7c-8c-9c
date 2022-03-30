class RelationshipsController < ApplicationController
  def follow_list
    user = User.find(params[:user_id])
    @follower_list = user.followers
  end
  def follower_list
    user = User.find(params[:user_id])
    @follower_list = user.followeds
  end

  def create
    followed = User.find(params[:user_id])
    relationship = Relationship.new
    relationship.follower_id = current_user.id
    relationship.followed_id = followed.id
    relationship.save
    
    redirect_to request.referer
   
  end
  def destroy
    user = User.find(params[:user_id])
    current_user.follower.find_by(followed_id: user.id).destroy

    # "https://d45db844a3944142abaa224a36ba527e.vfs.cloud9.us-east-1.amazonaws.com/users"
    redirect_to request.referer
  end
end
