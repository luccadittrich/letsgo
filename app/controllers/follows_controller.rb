class FollowsController < ApplicationController
  def create
    @follow = Follow.new(user: current_user, followed_id: params[:user_id])
    @follow.save
    Notification.create(user: User.find(params[:user_id]), content: "O usuário #{current_user.username} seguiu você.")
    redirect_to profile_path(params[:user_id])
  end

  def destroy
    @follows = Follow.find_by(user_id: current_user.id, followed_id: params[:user_id])
    @follows.destroy
    redirect_to profile_path(params[:id])
  end
end
